//
//  DestinationViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation
import NetworkManager

@MainActor class DestinationViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var destinations: [Destination] = []
    
    func getDestinations() {
        let networkManager = NetworkManager()
        
        Task {
            do {
                destinations = try await networkManager.fetch(from: "https://trendytravel.onrender.com/destinations") as [Destination]
                isLoading = false
            } catch {
                print("Error fetching destinations: \(error)")
            
            }
        }
    }
}
