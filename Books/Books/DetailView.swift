// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import BooksModel

struct DetailView: View {
    @Environment(\.colorScheme) private var colorScheme
    let darkGradient = RadialGradient(colors: [.black, .brown.opacity(0.2)], center: .center, startRadius: 80, endRadius: 200)
    let lightGradient = RadialGradient(colors: [.white, .brown.opacity(0.2)], center: .center, startRadius: 80, endRadius: 200)

    var book: Book
    
    private var heading: some View {
        VStack {
//            LibraryIcon(isInLibrary: book.isBookmarked)
            title
            HStack(alignment: .top, spacing: 12) {
                Spacer()
                image
                VStack(alignment: .leading, spacing: 9) {
                    Text(book.authorName)
                        .font(.headline)
                    Text("Price: \(book.formattedPrice)")
                        .padding(.top, -8)
                        .font(.subheadline)
                    RatingView(book: book)
                }
                Spacer()
            }
        }
        .padding()
        .padding(.bottom, 6)
        .background(colorScheme == .dark ? darkGradient : lightGradient)
    }
    
    private var title: some View {
        Text(book.title)
            .font(.title2)
            .multilineTextAlignment(.center)
            .lineSpacing(-1)
            .padding(.horizontal, 6)
            .padding(.vertical, 1)
    }
    
    private var image: some View {
        AsyncImage(url: book.artworkUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 90)
        } placeholder: {
            ProgressView()
        }
    }
        
    private var synopsis: some View {
        WebView(text: book.synopsis)
    }
    
    private var bookmarkSymbolName: String {
        "bookmark" + (book.isBookmarked ? ".fill" : "")
    }
    
    private var bookmarkButton: some View {
        Button(
            action: {
                book.isBookmarked ? removeFromBookmarks() : addToBookmarks()
            },
            label: {
                Image(systemName: bookmarkSymbolName)
            })
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Group {
                heading
                synopsis
            }
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 15)
            
            Spacer()
        }
        .background(.brown.opacity(0.2))
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(.stack)
        .navigationTitle("Details")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                bookmarkButton
            }
        }
    }
}

extension DetailView {
    
    private func addToBookmarks() {
        book.isBookmarked = true
//        Task {
//            try await viewModel.addToBookmarks()
//        }
    }
    
    private func removeFromBookmarks() {
        book.isBookmarked = false
//        Task {
//            try await viewModel.removeFromBookmarks()
//        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let book = TestData.book
    
    static var previews: some View {
        NavigationView {
            DetailView(book: book)
        }
        NavigationView {
            DetailView(book: book)
        }
        .preferredColorScheme(.dark)
    }
}
