//
//  FavoriteView.swift
//  Quotly
//
//  Created by Maciej Sołoducha on 11/09/2025.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Query(sort: \FavoriteQuote.createdAt, order: .reverse)
    private var quotes: [FavoriteQuote]
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            if quotes.isEmpty {
                VStack {
                    Spacer()
                    Text("No favorite quotes yet")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
                .navigationTitle("Favorite Quotes")
            } else {
                List {
                    ForEach(quotes) { quote in
                        VStack(alignment: .leading) {
                            Text(quote.content)
                                .font(.headline)
                            Text("- \(quote.author)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: deleteQuotes)
                }
                .navigationTitle("Favorite Quotes")
            }
        }
    }
    
    private func deleteQuotes(at offsets: IndexSet) {
        for index in offsets {
            context.delete(quotes[index])
        }
        try? context.save()
    }
}

#Preview {
    FavoriteView()
}
