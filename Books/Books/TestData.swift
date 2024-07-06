// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation
import BooksModel

struct TestData {
    static let queryString = "George Eliot Middlemarch"
    
    static var book: Book {
        books[0]
    }
    
    static var books: [Book] {
        let data = booksJSON.data(using: .utf8)!
        return try! JSONDecoder().decode([Book].self, from: data)
    }
    
    static let synopsis = "George Eliot was the pen-name of Mary Ann Evans, one of the greatest of English novelists of the Victorian era. Her long novel <i>Middlemarch</i>, subtitled <i>A Study of Provincial Life</i>, is generally considered to be her finest work.<br /><br />Published in eight installments between 1871 and 1872, <i>Middlemarch</i> tells the intertwined stories of a variety of people living in the vicinity of the (fictional) midlands town of Middlemarch during the early 1830s, the time of the great Reform Act. The novel is remarkable for its realistic treatment of situation, character and relationships and also demonstrates its author’s accurate knowledge of political issues, medicine, politics, and rural economy. Yet it also includes several touches of humor.<br /><br />The novel’s main characters include: Dorothea Brooke, a religiously-inclined and very intelligent young woman who marries a much older man believing that she can assist him in his scholarly studies; Dr. Tertius Lydgate, a doctor who comes to Middlemarch to further his medical research and implement his ideas for treatment, but whose plans are thrown into disarray by an unwise marriage; Fred Vincy, an idle young man, the son of the town’s Mayor, who gets into a mire of debt; and several others.<br /><br />The initial reception of the novel by critics was mixed, with a number of unfavorable reviews, but its reputation has grown through time and <i>Middlemarch</i> is now generally considered to be one of the best novels ever written in English."
}


private let booksJSON = """
[{
    "artworkUrl60": "https://is5-ssl.mzstatic.com/image/thumb/Publication4/v4/56/d9/c0/56d9c0b8-ed8f-6108-6c35-1bce66758812/cover.png/60x60bb.jpg",
    "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Publication4/v4/56/d9/c0/56d9c0b8-ed8f-6108-6c35-1bce66758812/cover.png/100x100bb.jpg",
    "artistViewUrl": "https://books.apple.com/us/artist/william-shakespeare/2765976?uo=4",
    "trackCensoredName": "The Complete Works of Shakespeare",
    "fileSizeBytes": 5550282,
    "formattedPrice": "Free",
    "trackViewUrl": "https://books.apple.com/us/book/the-complete-works-of-shakespeare/id916361560?uo=4",
    "artistIds": [
        2765976
    ],
    "genreIds": [
        "10036",
        "38",
        "9007"
    ],
    "releaseDate": "2014-09-04T07:00:00Z",
    "trackId": 916361560,
    "trackName": "The Complete Works of Shakespeare",
    "currency": "USD",
    "artistId": 2765976,
    "artistName": "William Shakespeare",
    "genres": [
        "Theater",
        "Books",
        "Arts & Entertainment"
    ],
    "price": 0.00,
    "description": "The most complete collection of Shakespeare's works available in a single book, containing 41 plays, 7 poems and 154 sonnets. This edition includes co-authored and rare apocrypha works, such as Sir Thomas More and Double Falsehood.",
    "kind": "ebook",
    "averageUserRating": 4.0,
    "userRatingCount": 49
},
{
    "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Publication/b2/9a/21/mzi.ovsptcyc.jpg/60x60bb.jpg",
    "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Publication/b2/9a/21/mzi.ovsptcyc.jpg/100x100bb.jpg",
    "artistViewUrl": "https://books.apple.com/us/artist/william-shakespeare/2765976?uo=4",
    "trackCensoredName": "Hamlet",
    "fileSizeBytes": 1282150,
    "formattedPrice": "Free",
    "trackViewUrl": "https://books.apple.com/us/book/hamlet/id446259625?uo=4",
    "artistIds": [
        2765976
    ],
    "genreIds": [
        "10036",
        "38",
        "9007",
        "9031",
        "10049",
        "10042"
    ],
    "releaseDate": "2011-06-23T07:00:00Z",
    "trackId": 446259625,
    "trackName": "Hamlet",
    "currency": "USD",
    "artistId": 2765976,
    "artistName": "William Shakespeare",
    "genres": [
        "Theater",
        "Books",
        "Arts & Entertainment",
        "Fiction & Literature",
        "Literary",
        "Classics"
    ],
    "price": 0.00,
    "description": "The ghost of the recently deceased king of Denmark appears on the walls of Elsinore Castle, crying out for vengeance against his brother and murderer, the recently crowned king Claudius. But Prince Hamlet cannot be certain of his own reality. Did he really see a ghost? Is the vengeance his father demands just? Can he murder his own uncle to appease his father? The more Hamlet broods and schemes, a shadow over Elsinore is growing ever darker, until a case of mistaken identity leaves an innocent bystander murdered. Then the entire court descends into a spiral of madness, chaos, bloodshed, and suffering. Shakespeare's most famous tragedy is a bone-chilling examination of justice, revenge, and inaction.",
    "kind": "ebook",
    "averageUserRating": 4.0,
    "userRatingCount": 537
},
{
    "artworkUrl60": "https://is3-ssl.mzstatic.com/image/thumb/Publication/a7/a5/43/mzi.zpoillon.jpg/60x60bb.jpg",
    "artworkUrl100": "https://is3-ssl.mzstatic.com/image/thumb/Publication/a7/a5/43/mzi.zpoillon.jpg/100x100bb.jpg",
    "artistViewUrl": "https://books.apple.com/us/artist/william-shakespeare/2765976?uo=4",
    "trackCensoredName": "Julius Caesar",
    "fileSizeBytes": 901253,
    "formattedPrice": "Free",
    "trackViewUrl": "https://books.apple.com/us/book/julius-caesar/id445888986?uo=4",
    "artistIds": [
        2765976
    ],
    "genreIds": [
        "10036",
        "38",
        "9007",
        "9031",
        "10042",
        "10049"
    ],
    "releaseDate": "2011-06-23T07:00:00Z",
    "trackId": 445888986,
    "trackName": "Julius Caesar",
    "currency": "USD",
    "artistId": 2765976,
    "artistName": "William Shakespeare",
    "genres": [
        "Theater",
        "Books",
        "Arts & Entertainment",
        "Fiction & Literature",
        "Classics",
        "Literary"
    ],
    "price": 0.00,
    "description": "As Julius Caesar ascends to status of dictator-for-life, Marcus Brutus is deeply disturbed. He loves Rome, wants it to succeed and wants it to thrive, but he fears that Caesar's ascent is threatening the democratic principles of the republic. Meanwhile, Cassius, a fellow senator, is quietly building a conspiracy devoted to removing Caesar once and for all. Torn between patriotism, loyalty to his friend, and his conflicted conscience, Brutus reluctantly agrees to join with the assassins, plotting a strike on the Ides of March...",
    "kind": "ebook",
    "averageUserRating": 4.0,
    "userRatingCount": 281
}]
"""
