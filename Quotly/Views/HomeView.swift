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
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg1")
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
    func textComponent () -> some View {
        VStack {
            // Quoute
            Text(vm.quote?.content ?? "")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
                .padding(.top,90)
                .foregroundStyle(.white)
            // Author
            Text("- \(vm.quote?.author ?? "")")
                .foregroundStyle(.white)
        }
    }
}

// - MARK: TabBar View -
extension HomeView {
    func tabBarComponent () -> some View {
        HStack {
            // 1st button (add to favorite list)
            FavoriteHeart(content: vm.quote?.content ?? "", author: vm.quote?.author ?? "")
            Spacer()
            // 2nd button (change quote)
            Button {
                vm.fetchQuote()
            } label: {
                Image(systemName: "arrow.trianglehead.2.clockwise")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
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
