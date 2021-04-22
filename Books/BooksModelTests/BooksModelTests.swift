// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest
@testable import BooksModel

let term1 = "Jane"
let term2 = "Austen"
let term3 = "Middlemarch"

class BooksModelTests: XCTestCase {
    
    func testBooksQueryWithNoSearchTerms() {
        let query = BooksQuery(searchTerms: [])
        let url = query.url
        XCTAssertNil(url)
    }

    func testBooksQueryWithMultipleSearchTerms() {
        let query = BooksQuery(searchTerms: [term1, term2, term3])
        let url = query.url!
        print(url)
        XCTAssert(url.absoluteString.hasSuffix("?media=ebook&explicit=No&country=us&limit=100&term=Jane+Austen+Middlemarch"))
    }
}
