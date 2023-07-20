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
    let selectedActivity: Activity

    let baseURLReviews = "https://trendytravel.onrender.com/reviews"
    let network = NetworkManager()

    init(selectedActivity: Activity) {
        self.selectedActivity = selectedActivity
        Task {
            await self.getReviews()
        }
    }

    func getReviews() async {
        do {
            let reviews: [Review] = try await network.fetch(from: baseURLReviews)
            DispatchQueue.main.async {
                self.review = reviews.filter {
                    $0.activityID == self.selectedActivity.id
                }
            }
        } catch {
            print(error)
        }
    }
}
