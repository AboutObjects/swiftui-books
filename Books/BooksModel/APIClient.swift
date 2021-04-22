// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation
import Combine

public final class APIClient
{
    let decoder = JSONDecoder()
    var subscriptions: Set<AnyCancellable> = []
    
    public func execute(query: BooksQuery, receiveBooks: @escaping ([Book]) -> Void) {
        guard let url = query.url else {
            fatalError("Unable to obtain URL from query \(query)")
        }
        
        subscriptions.removeAll()
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in data }
            .decode(type: BookSearchResult.self, decoder: decoder)
            .compactMap { searchResult in searchResult.books }
            .receive(on: DispatchQueue.main)
            .sink { completionType in
                print("\(completionType) loading quotes")
            } receiveValue: { books in
                receiveBooks(books)
            }
            .store(in: &subscriptions)
    }
}
