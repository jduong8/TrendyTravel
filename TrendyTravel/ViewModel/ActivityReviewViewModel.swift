//
//  ActivityReviewViewModel.swift
//  TrendyTravel
//
//  Created by Tatiana Simmer on 19/07/2023.
//


import Foundation
import NetworkManager

class ActivityReviewViewModel: ObservableObject {
    @Published var review: [Review] = []

    let baseURLReviews = "https://trendytravel.onrender.com/reviews"
    let network = NetworkManager()

    func getReviews() async throws -> [Review] {
        return try await network.fetch(from: baseURLReviews)
    }
}
