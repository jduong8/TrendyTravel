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
    
    let networkManager = NetworkManager()

    func getAllDestinations() {
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
        Task {
            do {
                var fetchedDestinations = try await networkManager.fetch(from: "https://trendytravel.onrender.com/destinations") as [Destination]

                // Filter destinations to include only those with activities that have ratings >= 4
                fetchedDestinations = fetchedDestinations.compactMap { destination in
                    guard let activities = destination.activities else {
                        // If activities is nil, don't include this destination
                        return nil
                    }

                    // If there's at least one activity with a rating >= 4, include this destination
                    return activities.contains { $0.rating >= 4 } ? destination : nil
                }

                // Sort destinations by total activities count
                fetchedDestinations.sort {
                    guard let lhsActivities = $0.activities, let rhsActivities = $1.activities else {
                        // If either activity list is nil, consider its count as 0
                        return ($0.activities?.count ?? 0) > ($1.activities?.count ?? 0)
                    }

                    // Compare the counts
                    return lhsActivities.count > rhsActivities.count
                }

                destinations = fetchedDestinations
                isLoading = false
            } catch {
                print("Error fetching destinations: \(error)")
                isLoading = false
            }
        }
    }
}
