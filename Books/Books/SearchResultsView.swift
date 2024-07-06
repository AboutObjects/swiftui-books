// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import BooksModel

struct SearchResultsView: View {
    @Bindable var viewModel: BooksViewModel
    
    var body: some View {
        NavigationStack {
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
                        .onAppear() { viewModel.next() }
                }
            }
            .navigationTitle("Book Search")
            .searchable(text: $viewModel.queryString)
            .onSubmit(of: .search) {
                viewModel.newSearch()
            }
        }
        .font(.title3)
        .lineLimit(1)
        .listStyle(PlainListStyle())
        .onAppear { viewModel.search() }
    }
}

struct BookCell: View {
    var book: Book
    
    var body: some View {
        HStack(spacing: 18) {
            Group {
                if let image = book.image {
                    Image(uiImage: image).resizable()
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

struct RatingView: View {
    var book: Book
    var rating: CGFloat { CGFloat(book.rating) }
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack {
            let stars = HStack(spacing: 0) {
                ForEach(0..<5) { count in
                    Image(systemName: rating == 0 ? "star" : "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(rating == 0 ? 
                            .accentColor : colorScheme == .dark ?
                            .black : .white)
                }
            }
            
            stars.overlay(
                GeometryReader { geometry in
                    let width = rating / 5.0 * geometry.size.width
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                            .foregroundColor(.accentColor)
                    }
                }
                .mask(stars)
            )
            .frame(maxWidth: 60)
        }
        
        Text("\(book.ratingText)")
            .font(.subheadline)
    }
}

struct LoadingIndicatorCell: View {
    
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
        Group {
            SearchResultsView(viewModel: BooksViewModel())
            SearchResultsView(viewModel: BooksViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
