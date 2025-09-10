//
//  ContentView.swift
//  Quotly
//
//  Created by Maciej Sołoducha on 10/09/2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = QuoteViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text(vm.quote?.content ?? "")
                    .font(.title)
                    .padding()
                Text(vm.quote?.author ?? "")
            }
            .padding()
        }
        .ignoresSafeArea()
        .onAppear() {
            vm.fetchQuote()
        }
        
    }
}

#Preview {
    HomeView()
}
