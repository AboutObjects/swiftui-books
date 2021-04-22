// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation

public class Author: Identifiable, CustomStringConvertible {
    public let id: Int
    public let name: String
    public private(set) var books: [Book] = []
    
    public func add(book: Book) {
        books.append(book)
    }
    
    public var description: String {
        books.reduce("\n\nid: \(id), name: \(name)\n===================\n") { "\($0)\t\($1.id), \($1.title)\n" }
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
