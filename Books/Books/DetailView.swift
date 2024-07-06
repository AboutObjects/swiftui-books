// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import BooksModel

struct DetailView: View {
    @Environment(\.colorScheme) private var colorScheme
    let darkGradient = RadialGradient(colors: [.black, .brown.opacity(0.2)], center: .center, startRadius: 80, endRadius: 200)
    let lightGradient = RadialGradient(colors: [.white, .brown.opacity(0.2)], center: .center, startRadius: 80, endRadius: 200)

    var book: Book
    
    var heading: some View {
        VStack {
            LibraryIcon(isInLibrary: book.isInLibrary)
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
    
    var title: some View {
        Text(book.title)
            .font(.title2)
            .multilineTextAlignment(.center)
            .lineSpacing(-1)
            .padding(.horizontal, 6)
            .padding(.vertical, 1)
    }
    
    var image: some View {
        AsyncImage(url: book.artworkUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 90)
        } placeholder: {
            ProgressView()
        }
    }
        
    var synopsis: some View {
        WebView(text: book.synopsis)
    }
    
    var addButton: some View {
        Button(
            action: { addToLibrary() },
            label: {
                Image(systemName: "plus.circle.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 20))
            })
        .disabled(book.isInLibrary)
        .opacity(book.isInLibrary ? 0.4 : 1.0)
    }
    
    var removeButton: some View {
        Button(
            action: { removeFromLibrary() },
            label: {
                Image(systemName: "minus.circle.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 20))
            })
        .disabled(!book.isInLibrary)
        .opacity(book.isInLibrary ? 1.0 : 0.4)
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
                removeButton
                addButton
            }
        }
    }
}

extension DetailView {
    
    private func addToLibrary() {
//        Task {
//            try await viewModel.addBookToLibrary()
//        }
    }
    
    private func removeFromLibrary() {
//        Task {
//            try await viewModel.removeBookFromLibrary()
//        }
    }
}

struct LibraryIcon: View {
    let isInLibrary: Bool
    
    var body: some View {
        Image(systemName: "books.vertical" + (isInLibrary ? ".fill" : ""))
            .imageScale(.large)
            .font(.system(size: 18))
            .opacity(isInLibrary ? 1.0 : 0.3)
            .padding(.top, 3)
            .foregroundColor(.brown)
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
