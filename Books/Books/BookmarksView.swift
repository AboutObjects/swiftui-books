//
//  Created 7/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI
import BooksModel

struct BookmarksView: View {
    var viewModel: BooksViewModel
    
    var bookList: some View {
        List {
            ForEach(viewModel.bookmarkedBooks, id: \.id) { book in
                NavigationLink {
                    DetailView(book: book)
                } label: {
                    BookCell(book: book)
                }
            }
        }
        .font(.title3)
        .lineLimit(1)
        .listStyle(PlainListStyle())
    }
    
    var emptyListMessage: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("No Bookmarks")
                .font(.headline)
            Text("To add a bookmark, view a book in the Search tab and tap its bookmark button.")
                .font(.subheadline)
            Spacer()
        }
        .padding(20)
        .foregroundStyle(.secondary)

    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.bookmarkedBooks.isEmpty {
                    emptyListMessage
                } else {
                    bookList
                }
            }
            .navigationTitle("Bookmarks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    BookmarksView(viewModel: BooksViewModel())
}
