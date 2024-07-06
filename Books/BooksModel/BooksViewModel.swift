// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import UIKit
import Combine
import Observation

public extension String
{
    var searchTerms: [String] {
        return components(separatedBy: .whitespaces)
    }
}

@Observable public final class BooksViewModel
{
    public private(set) var books: [Book] = []
    public var isAtEnd = false
    public var isSearching = false
    public var queryString = "George Eliot Middlemarch"
    
    private var query: BooksQuery!
    private let apiClient = APIClient()
    
    public init() { }
}

public extension BooksViewModel
{
    private func makeQuery() -> BooksQuery {
        // TODO: Ignore empty or nil search terms
        let terms = queryString.searchTerms
        return BooksQuery(searchTerms: terms, offset: books.count)
    }
    
    func newSearch() {
        books = []
        search()
    }
    
    func search() {
        query = makeQuery()
        Task {
            // For testing purposes:
            // try await Task.sleep(for: .seconds(1))
            
            let fetchedBooks = try await apiClient.execute(query: query)
            self.books.append(contentsOf: fetchedBooks)
            self.books.forEach { book in
                Task.detached {
                    let data = try await self.apiClient.fetch(url: book.artworkUrl)
                    book.image = UIImage(data: data)
                }
            }
            self.isSearching = false
            if let query = self.query, self.books.count < query.fetchLimit {
                self.isAtEnd = true
            }
        }
    }
    
    
    func next() {
        search()
    }
}
