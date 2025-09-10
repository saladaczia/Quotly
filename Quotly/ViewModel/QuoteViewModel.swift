//
//  QuoteViewModel.swift
//  Quotly
//
//  Created by Maciej Sołoducha on 10/09/2025.
//

import Foundation
import Combine

class QuoteViewModel: ObservableObject {
    @Published var quote: QuoteModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellabless = Set<AnyCancellable>()
    
    
    func fetchQuote() {
        isLoading = true
        errorMessage = nil
        
        let url = URL(string: "http://api.quotable.io/random")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: QuoteModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] quote in
                self?.quote = quote
            }
            .store(in: &cancellabless)
    }
}
