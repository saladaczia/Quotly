//
//  FavoriteQuote.swift
//  Quotly
//
//  Created by Maciej Sołoducha on 12/09/2025.
//

import Foundation
import SwiftData

@Model
class FavoriteQuote {
    var quote: String
    var author: String
    var createdAt: Date
    
    init(quote: String, author: String, createdAt: Date = .now) {
        self.quote = quote
        self.author = author
        self.createdAt = createdAt
    }
}
