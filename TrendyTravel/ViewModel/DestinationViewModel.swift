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
    
    func getAllDestinations() {
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
    
    // Get popular destination
    func getPopularDestinations() {
        let networkManager = NetworkManager()
        
        Task {
            do {
                var fetchedDestinations = try await networkManager.fetch(from: "https://trendytravel.onrender.com/destinations") as [Destination]
                
                // Filter destinations to include only those with activities that have ratings >= 4
                fetchedDestinations = fetchedDestinations.filter { destination in
                    destination.activities.contains { activity in
                        activity.rating >= 4
                    }
                }
                
                // Sort destinations by total activities count
                fetchedDestinations.sort { $0.activities.count > $1.activities.count }
                
                destinations = fetchedDestinations
                isLoading = false
            } catch {
                print("Error fetching destinations: \(error)")
                isLoading = false
            }
        }
    }

}
