// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation
import Combine

public final class BooksViewModel: ObservableObject
{
    @Published public private(set) var books: [Book] = []
    @Published var isSearching = false
    @Published var queryString: String?
    
    private let dataStore = DataStore()
    
    public init() { }
}

public extension BooksViewModel
{
    private var searchTerms: [String]? {
        return queryString?.components(separatedBy: .whitespaces)
    }
    
    private var query: BooksQuery {
        // TODO: Ignore empty search terms
        let terms = searchTerms ?? [ "George", "Eliot", "Middlemarch" ]
        return BooksQuery(searchTerms: terms)
    }
    
    func search() {
        dataStore.query = query
        dataStore.search { [weak self] in self?.receive(books: $0) }
    }

    private func receive(books: [Book]) {
        self.books.append(contentsOf: books)
        isSearching = false
    }
}
