//
//  QuotlyApp.swift
//  Quotly
//
//  Created by Maciej Sołoducha on 10/09/2025.
//

import SwiftUI
import SwiftData

@main
struct QuotlyApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: FavoriteQuote.self)
    }
}
