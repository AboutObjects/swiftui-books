// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import BooksModel

struct SearchResultsView: View {
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.bookViewModels, id: \.book.id) { bookViewModel in
                BookCell(bookViewModel: bookViewModel)
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
    @ObservedObject var bookViewModel: BookViewModel
    
    var body: some View {
        HStack(spacing: 18) {
            Group {
                if bookViewModel.image != nil {
                    Image(uiImage: bookViewModel.image!).resizable()
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
                Text(bookViewModel.book.title)
                    .font(.headline)
                Text(bookViewModel.book.authorName)
                    .font(.subheadline)
                Text(bookViewModel.book.formattedPrice)
                    .font(.subheadline)
                RatingView(bookViewModel: bookViewModel)
            }
        }
    }
}

struct RatingView: View {
    @ObservedObject var bookViewModel: BookViewModel
    let maxRating = 5
    var rating: CGFloat { CGFloat(bookViewModel.rating) }
    
    var body: some View {
        HStack {
            let stars = HStack(spacing: 0) {
                ForEach(0..<maxRating) { count in
                    Image(systemName: rating == 0 ? "star" : "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(rating == 0 ? .yellow : .white)
                }
            }
            
            stars.overlay(
                GeometryReader { geometry in
                    let width = rating / CGFloat(maxRating) * geometry.size.width
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                            .foregroundColor(.yellow)
                    }
                }
                .mask(stars)
            )
            .frame(maxWidth: 80)
        }
        
        Text("\(bookViewModel.ratingText)")
            .font(.subheadline)
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
