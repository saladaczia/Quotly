//
//  FavoriteHeart.swift
//  Quotly
//
//  Created by Maciej Sołoducha on 12/09/2025.
//

import SwiftUI
import SwiftData

// Heart button to add/remove favorite
struct FavoriteHeart: View {
    @Environment(\.modelContext) private var context
    
    let content: String // Quote text
    let author: String // Quote author
    
    // Check if this quote is already in favorites
    @Query private var matches: [FavoriteQuote]
    
    init(content: String, author: String) {
        self.content = content
        self.author = author
        _matches = Query(
            filter: #Predicate<FavoriteQuote> { fav in
                fav.content == content && fav.author == author
            }
        )
    }
    
    // Favorite state
    private var isFavorite: Bool { !matches.isEmpty }
    
    // Heart icon view
    var body: some View {
        Button {
            withAnimation(.snappy) { toggleFavorite() }
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundStyle(isFavorite ? .red : .white)
                .symbolEffect(.bounce, value: isFavorite) // animation
        }
        .buttonStyle(.plain)
    }
    
    // Toggle favorite
    private func toggleFavorite() {
        if let existing = matches.first {
            context.delete(existing)
        } else {
            context.insert(FavoriteQuote(content: content, author: author))
        }
        try? context.save()
    }
}

#Preview {
    FavoriteHeart(content: "test", author: "test")
        .padding()
        .background(Color.black)
}
