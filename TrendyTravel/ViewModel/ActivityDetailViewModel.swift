//
//  ActivityDetailViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation
import NetworkManager

class ActivityDetailViewModel: ObservableObject {
    @Published var activity: [Activity] = []
    
    
    let baseURLActivities = "https://trendytravel.onrender.com/activities"
    let network = NetworkManager()
    
    func getActivities() async throws -> [Activity] {
        return try await network.fetch(from: baseURLActivities)
    }
    
}
