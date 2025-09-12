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
    var content: String
    var author: String
    var createAt: Date
    
    init(content: String, author: String, createAt: Date = .now) {
        self.content = content
        self.author = author
        self.createAt = createAt
    }
}
