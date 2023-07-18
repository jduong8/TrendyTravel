//
//  CategoryDetailsViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation
import NetworkManager

class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var activities: [Activity] = []
    @Published var category: Category = .culture
    @Published var errorMessage = ""
    
    let urlString = "https://trendytravel.onrender.com/activities"

    func getActivities(from category: Category) async {
        let api = NetworkManager()
        do {
            let fetchedActivities: [Activity] = try await api.fetch(from: urlString)
            DispatchQueue.main.async {
                self.activities = fetchedActivities.filter {
                    $0.category == category.rawValue
                }
                if !self.activities.isEmpty {
                    self.isLoading = false
                }
                self.category = category
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
