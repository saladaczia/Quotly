//
//  ContentView.swift
//  Quotly
//
//  Created by Maciej Sołoducha on 10/09/2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = QuoteViewModel()
    @State var isFavorite: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    Text(vm.quote?.content ?? "")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.top,90)
                        .foregroundStyle(.white)
                    Text(vm.quote?.author ?? "")
                        .foregroundStyle(.white)
                    Spacer()
                    
                    TabBar()
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            }
        }
        
    }
}

#Preview {
    HomeView()
}

// - MARK: TabBar View -
extension HomeView {
    func TabBar () -> some View {
        HStack {
            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
            }
            Spacer()
            Button {
                vm.fetchQuote()
                isFavorite = false
            } label: {
                Image(systemName: "arrow.trianglehead.2.clockwise")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
            }
            Spacer()
            NavigationLink {
                FavoriteView()
            } label: {
                Image(systemName: "list.bullet.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
            }
        }
        .padding()
    }
}
