// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest
@testable import BooksModel

let jsonString = """
{"artworkUrl60":"https://is5-ssl.mzstatic.com/image/thumb/Publication5/v4/59/16/41/59164139-1ec9-8191-935c-0fb5c3d76473/source/60x60bb.jpg", "artworkUrl100":"https://is5-ssl.mzstatic.com/image/thumb/Publication5/v4/59/16/41/59164139-1ec9-8191-935c-0fb5c3d76473/source/100x100bb.jpg", "artistViewUrl":"https://books.apple.com/us/artist/george-eliot/28596172?uo=4", "trackCensoredName":"Middlemarch", "fileSizeBytes":812727, "formattedPrice":"Free", "trackViewUrl":"https://books.apple.com/us/book/middlemarch/id392612355?uo=4", "trackId":392612355, "trackName":"Middlemarch", "releaseDate":"1874-01-01T07:00:00Z", "genreIds":["10084", "38", "9031"], "artistIds":[28596172], "currency":"USD", "kind":"ebook", "artistId":28596172, "artistName":"George Eliot", "genres":["Literary Criticism", "Books", "Fiction & Literature"], "price":0.00,
"description":"Making masterful use of a counter pointed plot, Eliot presents the stories of a number of denizens of a small English town on the eve of the Reform Bill of 1832. The main characters, Dorothea Brooke and Tertius Lydgate, each long for exceptional lives but are powerfully constrained by their own unrealistic expectations as well as conservative society. The novel is notable for its deep psychological insight and sophisticated character portraits.", "averageUserRating":4.5, "userRatingCount":632}
"""

let term1 = "Jane"
let term2 = "Austen"
let term3 = "Middlemarch"

let decoder = JSONDecoder()

typealias JSONDictionary = [String: Any]

class BooksModelTests: XCTestCase {
    
    var json: [String: Any] {
        let data = jsonString.data(using: .utf8)!
        return try! JSONSerialization.jsonObject(with: data, options: []) as! JSONDictionary
    }
    
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
    
    func testDecodeBook() {
        let data = jsonString.data(using: .utf8)!
        let book = try! decoder.decode(Book.self, from: data)
        print(book)
    }
    
    func testExecuteQuery() {
        let expectation = XCTestExpectation()
        
        let client = APIClient()
        let query = BooksQuery(searchTerms: [term3])
        client.execute(query: query) { books in
            print(books)
            XCTAssert(!books.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }

    func testAuthors() {
        let expectation = XCTestExpectation()
        
        let store = DataStore()
        let client = APIClient()
        let query = BooksQuery(searchTerms: [term3])
        client.execute(query: query) { books in
            store.set(books: books)
            let authors = store.authors
            print(authors)
            XCTAssert(!authors.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }


    func testSearchForAuthors() {
        let expectation = XCTestExpectation()
        
        let store = DataStore()
        store.query = BooksQuery(searchTerms: [term3])
        store.search() { books in
            let authors = store.authors
            print(authors)
            XCTAssert(!authors.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
