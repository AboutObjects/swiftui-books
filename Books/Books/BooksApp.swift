// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import BooksModel

@main
struct BooksApp: App {
    @State var booksViewModel = BooksViewModel()
    
    var body: some Scene {
        WindowGroup {
            SearchResultsView()
                .environment(booksViewModel)
        }
    }
}
