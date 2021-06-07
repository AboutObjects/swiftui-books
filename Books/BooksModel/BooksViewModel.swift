// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import UIKit
import Foundation
import Combine

public extension String
{
    var searchTerms: [String] {
        return components(separatedBy: .whitespaces)
    }
}

public final class BooksViewModel: ObservableObject
{
    @Published public private(set) var books: [Book] = []
    @Published public private(set) var bookViewModels: [BookViewModel] = []
    @Published public var isAtEnd = false
    @Published public var isSearching = false
    @Published public var queryString: String?
    
    private var query: BooksQuery!
    private let apiClient = APIClient()
    
    public init() { }
}

public extension BooksViewModel
{
    private func makeQuery() -> BooksQuery {
        // TODO: Ignore empty or nil search terms
        let terms = queryString?.searchTerms ?? [ "George", "Eliot", "Middlemarch" ]
        return BooksQuery(searchTerms: terms, offset: books.count)
    }
    
    func search() {
        query = makeQuery()
        apiClient.execute(query: query) { [weak self] books in
            guard let self = self else { return }
            self.receive(fetchedBooks: books)
            if let query = self.query, self.books.count < query.fetchLimit {
                self.isAtEnd = true
            }
        }
    }
    
    func next() {
        search()
    }

    private func receive(fetchedBooks: [Book]) {
        books.append(contentsOf: fetchedBooks)
        bookViewModels = books.map { book in
            BookViewModel(book: book, apiClient: apiClient)
        }
        isSearching = false
    }
}

public final class BookViewModel: ObservableObject
{
    @Published public private(set) var image: UIImage?
    @Published public private(set) var book: Book
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        return formatter
    }()
    
    public var rating: Double {
        book.averageRating ?? 0
    }
    
    public var ratingText: String {
        let ratingText = Self.numberFormatter.string(from: NSNumber(value: book.averageRating ?? 0)) ?? "-.-"
        return "\(ratingText)  \(book.ratingCount ?? 0) Reviews"
    }
    
    private let apiClient: APIClient
    
    init(book: Book, apiClient: APIClient) {
        self.book = book
        self.apiClient = apiClient
        
        fetchImage()
    }
    
    private func fetchImage() {
        apiClient.fetch(url: book.artworkUrl) { [weak self] data in
            self?.image = UIImage(data: data)
        }
    }
}
