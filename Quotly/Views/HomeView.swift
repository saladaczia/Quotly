//
//  ContentView.swift
//  Quotly
//
//  Created by Maciej Sołoducha on 10/09/2025.
//

import SwiftUI

struct HomeView: View {
    // View model StateObject
    @StateObject private var vm = QuoteViewModel()
    @State var backgroundImageNumer: Int = Int.random(in: 1...7)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg\(backgroundImageNumer)")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    
                
                VStack {
                    // View Quote
                    textComponent()
                    Spacer()
                    // View Buttons
                    tabBarComponent()
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            }
            // ZStack End
        }
        // Navigation Stack End
    }
}

#Preview {
    HomeView()
}

extension HomeView {
    func textComponent() -> some View {
        VStack {
            if let quote = vm.quotes {
                Text("„\(quote.quote)”")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.top, 90)
                    .foregroundStyle(.white)
                    .shadow(color: .black, radius: 10)
                
                Text("- \(quote.author)")
                    .foregroundStyle(.white)
                    .shadow(color: .black, radius: 10)
            } else if vm.errorMessage != nil {
                // Placeholder when there's no quote
                Text("No quote available.")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 90)
                Text("Please check your internet connection.")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 90)
            }
        }
    }
}
// - MARK: TabBar View -
extension HomeView {
    func tabBarComponent () -> some View {
        HStack {
            // 1st button (add to favorite list)
            FavoriteHeart(quote: vm.quotes?.quote ?? "", author: vm.quotes?.author ?? "")
            Spacer()
            // 2nd button (change quote)
            Button {
                vm.fetchQuote()
                backgroundImageNumer = Int.random(in: 1...7)
            } label: {
                Image(systemName: "arrow.trianglehead.2.clockwise")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.white)
                    .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0)) // obrót
                    .animation(
                        vm.isLoading
                        ? .linear(duration: 1).repeatForever(autoreverses: false)
                        : .default,
                        value: vm.isLoading
                    )
            }
            Spacer()
            // 3rd button (view favorite list - navigation link)
            NavigationLink {
                FavoriteView()
            } label: {
                Image(systemName: "list.bullet.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 35, height: 35)
            }
        }
        .padding()
    }
}
