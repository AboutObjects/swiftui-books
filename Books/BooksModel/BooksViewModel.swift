// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation
import Combine

public final class BooksViewModel: ObservableObject
{
    @Published public private(set) var books: [Book] = []
    @Published public var isAtEnd = false
    @Published public var isSearching = false
    @Published var queryString: String?
    
    private let dataStore = DataStore()
    
    public init() { }
}

public extension BooksViewModel
{
    private var searchTerms: [String]? {
        return queryString?.components(separatedBy: .whitespaces)
    }
    
    private func makeQuery() -> BooksQuery {
        // TODO: Ignore empty or nil search terms
        let terms = searchTerms ?? [ "George", "Eliot", "Middlemarch" ]
        return BooksQuery(searchTerms: terms, offset: books.count)
    }
    
    func search() {
        dataStore.query = makeQuery()
        dataStore.search { [weak self] in
            guard let self = self else { return }
            self.receive(books: $0)
            if let query = self.dataStore.query, self.books.count < query.fetchLimit {
                self.isAtEnd = true
            }
        }
    }
    
    func next() {
        search()
    }

    private func receive(books: [Book]) {
        self.books.append(contentsOf: books)
        isSearching = false
    }
}
