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

    func getReviews(from activity: Activity, from user: User) async throws {
        do {
            let reviews: [Review] = try await network.fetch(from: baseURLReviews)
            self.review = reviews.filter {
                $0.activity == activity &&
                $0.user == user
            }
        } catch {
            print(error)
        }
    }
}
