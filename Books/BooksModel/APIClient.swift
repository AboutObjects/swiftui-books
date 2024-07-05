// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation
import Combine

public final class APIClient
{
    private let decoder = JSONDecoder()
    private var subscriptions: Dictionary<String, AnyCancellable> = [:]
    
    public func execute(query: BooksQuery) async throws -> [Book] {
        guard let url = query.url else {
            fatalError("Unable to obtain URL from query \(query)")
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try decoder.decode(BookSearchResult.self, from: data)        
        return result.books.compactMap { $0 }
    }
    
    public func fetch(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

// MARK: - Combine version
extension APIClient {
    
    public func execute(query: BooksQuery, receiveBooks: @escaping ([Book]) -> Void) {
        guard let url = query.url, let queryString = url.query else {
            fatalError("Unable to obtain URL from query \(query)")
        }
        
        let subscription = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in data }
            .decode(type: BookSearchResult.self, decoder: decoder)
            .compactMap { searchResult in searchResult.books }
            .receive(on: DispatchQueue.main)
            .sink { completionType in
                print("\(completionType) loading books")
                self.subscriptions.removeValue(forKey: queryString)
            } receiveValue: { books in
                receiveBooks(books)
            }
        
        subscriptions[queryString] = subscription
    }
    
    public func fetch(url: URL, receiveData: @escaping (Data) -> Void) {
        let subscription = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in data }
            .receive(on: DispatchQueue.main)
            .sink { completionType in
                self.subscriptions.removeValue(forKey: url.path)
            } receiveValue: { data in
                receiveData(data)
            }
        
        subscriptions[url.path] = subscription
    }
}
