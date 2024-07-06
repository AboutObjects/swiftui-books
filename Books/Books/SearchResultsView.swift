// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import BooksModel

struct SearchResultsView: View {
    @Bindable var viewModel: BooksViewModel
    
    var bookList: some View {
        List {
            ForEach(viewModel.books, id: \.id) { book in
                NavigationLink {
                    DetailView(book: book)
                } label: {
                    BookCell(book: book)
                }
            }
            
            if !viewModel.isAtEnd {
                LoadingIndicatorCell()
                    .onAppear() {
                        viewModel.next()
                    }
            }
        }
        .font(.title3)
        .lineLimit(1)
        .listStyle(PlainListStyle())
    }
    
    var emptyListMessage: some View {
        VStack(spacing: 12) {
            Text("No Books")
                .font(.headline)
            Text("Enter one or more terms in the search field above and tap the Search key.")
                .font(.subheadline)
                .lineSpacing(2)
        }
        .padding(.horizontal, 24)
        .foregroundStyle(.secondary)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isSearching {
                    ProgressView()
                } else if viewModel.books.isEmpty {
                    emptyListMessage
                } else {
                    bookList
                }
            }
            .navigationTitle("Book Search")
        }
        .searchable(text: $viewModel.queryString)
        .onSubmit(of: .search) {
            viewModel.newSearch()
        }
        .onAppear {
            viewModel.search()
        }
    }
}

struct BookCell: View {
    var book: Book
    
    var body: some View {
        HStack(spacing: 18) {
            Group {
                if let image = book.image {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .imageScale(.large)
                        .foregroundColor(.secondary)
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 80)
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.authorName)
                Text(book.formattedPrice)
                RatingView(book: book)
            }
            .font(.subheadline)
        }
    }
}

struct LoadingIndicatorCell: View {
    
    var body: some View {
        HStack {
            Spacer()
            LoadingIndicator()
            Spacer()
        }
        .frame(height: 120)
    }
}

struct SearchResults_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let viewModel = BooksViewModel(queryString: TestData.queryString)
            SearchResultsView(viewModel: viewModel)
            SearchResultsView(viewModel: viewModel)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
            SearchResultsView(viewModel: BooksViewModel())
                .previewDisplayName("Empty List")
        }
    }
}
