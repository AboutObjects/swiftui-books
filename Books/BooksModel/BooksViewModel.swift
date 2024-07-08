// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import UIKit
import Combine
import Observation

public extension String {
    var searchTerms: [String] {
        return components(separatedBy: .whitespaces)
    }
}

@Observable public final class BooksViewModel {
    
    public private(set) var books: [Book] = []
    public var isAtEnd = false
    public var isSearching = false
    public var queryString = ""
    
    private var query: BooksQuery!
    private let apiClient = APIClient()
    
    public init(queryString: String = "") {
        self.queryString = queryString
    }
}

public extension BooksViewModel {
    
    private func makeQuery() -> BooksQuery {
        // TODO: Ignore empty or nil search terms
        let terms = queryString.searchTerms
        return BooksQuery(searchTerms: terms, offset: books.count)
    }
    
    func newSearch() {
        isSearching = true
        books = []
        search()
    }
    
    func search() {
        query = makeQuery()
        Task {
            // For testing purposes:
            // try await Task.sleep(for: .seconds(1))
            // ...or use Network Link Conditioner
            
            let fetchedBooks = try await apiClient.execute(query: query)
            books.append(contentsOf: fetchedBooks)
            books.forEach { book in
                Task {
                    let data = try await self.apiClient.fetch(url: book.artworkUrl)
                    book.image = UIImage(data: data)
                }
            }
            
            isSearching = false
            
            if let query = query {
                isAtEnd = books.count % query.fetchLimit != 0
            }
        }
    }
    
    func next() {
        search()
    }
}
