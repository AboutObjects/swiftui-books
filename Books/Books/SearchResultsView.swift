// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import BooksModel

struct SearchResultsView: View {
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.books) { book in
                BookCell(text: book.title)
            }
            if !viewModel.isAtEnd {
                LoadingIndicatorCell()
                    .onAppear() { viewModel.next() }
            }
        }
        .font(.title3)
        .lineLimit(1)
        .listStyle(PlainListStyle())
        .onAppear { viewModel.search() }
    }
}

struct BookCell: View {
    var text: String
    var body: some View {
        Text(text)
    }
}

struct LoadingIndicatorCell: View {
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        HStack {
            Spacer()
            LoadingIndicator()
            Spacer()
        }
    }
}

struct SearchResults_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
            .environmentObject(BooksViewModel())
    }
}
