//
//  Created 7/6/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI
import BooksModel

struct RatingView: View {
    @Environment(\.colorScheme) private var colorScheme
    var book: Book
    var rating: CGFloat { CGFloat(book.rating) }
    
    var body: some View {
        HStack {
            let stars = HStack(spacing: 0) {
                ForEach(0..<5) { count in
                    Image(systemName: rating == 0 ? "star" : "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(rating == 0 ?
                            .secondary : colorScheme == .dark ?
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

