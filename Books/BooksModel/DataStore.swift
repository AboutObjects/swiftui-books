// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation

public class DataStore
{
    public var query: BooksQuery?
    public private(set) var books: [Book] = []
    private var _authors: [Author] = []
    
    private let apiClient: APIClient
    
    public var authors: [Author] {
        books.forEach { book in
            author(for: book).add(book: book)
        }
        return _authors
    }
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    public func author(for book: Book) -> Author {
        if let author = (_authors
                            .filter { author in author.id == book.authorId }
                            .first) {
            return author
        }
        
        let author = Author(id: book.authorId, name: book.authorName)
        _authors.append(author)
        
        return author
    }
    
    public func add(author: Author) {
        _authors.append(author)
    }
    
    public func set(books: [Book]) {
        self.books = books
    }
    
    public func search(receive: @escaping ([Book]) -> Void) {
        guard let query = query else {
            fatalError("Query cannot be nil.")
        }
        
        apiClient.execute(query: query) { books in
            self.books.append(contentsOf: books)
            receive(books)
        }
    }
}
