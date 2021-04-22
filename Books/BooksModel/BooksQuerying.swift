// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation

public extension String {
    static let space = " "
    static let plus = "+"
    static let ampersand = "&"
}

public protocol BooksQuerying {
    var media: String { get }
    var explicit: Bool { get }
    var country: String { get }
    var fetchLimit: Int { get }
    var searchTerms: [String] { get }
    
    var queryString: String { get }
    var url: URL? { get }
    
    init(searchTerms: [String])
}

public struct BooksQuery: BooksQuerying {
    public static let searchUrlString = "https://itunes.apple.com/search"
    public let media = "ebook"
    public let explicit = false
    public var country = "us"
    public var fetchLimit: Int = 100
    public var searchTerms: [String]
    
    public var searchTermsString: String {
        searchTerms.joined(separator: String.plus)
    }
    
    public var queryString: String {
        queryParameters.joined(separator: String.ampersand)
    }
    
    public var queryParameters: [String] {
        ["media=\(media)",
         "explicit=\(explicit ? "Yes" : "No")",
         "country=\(country)",
         "limit=\(fetchLimit)",
         "term=\(searchTermsString)"]
    }
    
    public var url: URL? {
        guard !searchTerms.isEmpty,
              let query = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            print("Unable to url encode query string: \(queryString)")
            return nil
        }
        return URL(string: "\(Self.searchUrlString)?\(query)")
    }
    
    public init(searchTerms: [String]) {
        self.searchTerms = searchTerms
    }
}