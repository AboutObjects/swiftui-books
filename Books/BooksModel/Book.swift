// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import UIKit
import Observation

private let decoder = JSONDecoder()
private let iso8601DateFormatter = ISO8601DateFormatter()

public struct BookSearchResult: Codable {
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case books = "results"
    }
    let count: Int
    let books: [Book]
}

@Observable public final class Book: Codable, Identifiable, Equatable {
    public static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: Int
    public let title: String
    public let authorId: Int
    public let authorName: String
    public let synopsis: String
    public let releaseDate: Date?
    public let formattedPrice: String
    public let genres: [String]
    public let fileSizeBytes: Int
    public let averageRating: Double?
    public let ratingCount: Int?
    public let artworkUrl: URL
    public let detailsUrl: URL
    
    public var image: UIImage?
    public var isBookmarked = false
    
    private enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackCensoredName"
        case authorId = "artistId"
        case authorName = "artistName"
        case synopsis = "description"
        case releaseDate
        case formattedPrice
        case genres
        case fileSizeBytes
        case averageRating = "averageUserRating"
        case ratingCount = "userRatingCount"
        case artworkUrl = "artworkUrl100"
        case detailsUrl = "trackViewUrl"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        authorId = try container.decode(Int.self, forKey: .authorId)
        authorName = try container.decode(String.self, forKey: .authorName)
        synopsis = try container.decode(String.self, forKey: .synopsis)
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        releaseDate = iso8601DateFormatter.date(from: dateString)
        formattedPrice = try container.decode(String.self, forKey: .formattedPrice)
        genres = try container.decode([String].self, forKey: .genres)
        fileSizeBytes = try container.decode(Int.self, forKey: .fileSizeBytes)
        averageRating = try container.decodeIfPresent(Double.self, forKey: .averageRating)
        ratingCount = try container.decodeIfPresent(Int.self, forKey: .ratingCount)
        artworkUrl = try container.decode(URL.self, forKey: .artworkUrl)
        detailsUrl = try container.decode(URL.self, forKey: .detailsUrl)
    }
}

extension Book {
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        return formatter
    }()
    
    public var rating: Double {
        averageRating ?? 0
    }
    
    public var ratingText: String {
        let text = Self.numberFormatter.string(from: NSNumber(value: averageRating ?? 0)) ?? "-.-"
        return "\(text)  \(ratingCount ?? 0) Reviews"
    }
}
