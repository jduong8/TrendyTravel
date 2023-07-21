//
//  ActivityReviewViewModel.swift
//  TrendyTravel
//
//  Created by Tatiana Simmer on 19/07/2023.
//


import Foundation
import NetworkManager
import Combine

@MainActor class ActivityReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var review: Review = .initial
    
    let selectedActivity: Activity
    
    let baseURLReviews = "https://trendytravel.onrender.com/reviews"
    let network = NetworkManager()
    
    // Function to get the current user's ID (Replace with your actual implementation)
    func getCurrentUserID() -> Int {
        return 1
    }
    
    
    
    init(selectedActivity: Activity) {
        self.selectedActivity = selectedActivity
        Task {
            await self.getReviews()
        }
    }
    
    @MainActor func getReviews() async {
        do {
            let reviews: [Review] = try await network.fetch(from: baseURLReviews)
            DispatchQueue.main.async {
                self.reviews = reviews.filter {
                    $0.activityID == self.selectedActivity.id
                }
            }
        } catch {
            print(error)
        }
    }
    
    private func createReview(review: Review) async throws -> Review {
        guard let url = URL(string: baseURLReviews)
        else {
            fatalError("Missing url")
        }
        
        let body: [String: Any] = ["content": review.content,
                                   "rating": review.rating,
                                   "userId": getCurrentUserID(),
                                   "activityId": selectedActivity.id
        ]
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        
        let decodedReview = try decoder.decode(Review.self, from: data)
        
        return decodedReview
    }
    
    func addCreatedReview(review: Review) async throws -> Review {
        do {
            let newReview = try await createReview(review: review)
            DispatchQueue.main.async {
                self.review = newReview
            }
            await getReviews()
        } catch {
            print(error)
        }
        return self.review
    }
    
}
