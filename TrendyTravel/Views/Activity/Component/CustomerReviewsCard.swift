//
//  CustomerReviewsCard.swift
//  TrendyTravel
//
//  Created by Tatiana Simmer on 19/07/2023.
//


import SwiftUI

struct ActivityReviewsView: View {
    @ObservedObject var reviewViewModel: ActivityReviewViewModel
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            Text("Customer Reviews")
                .font(.system(size: 16, weight: .bold))
            ForEach(reviewViewModel.review, id: \.id) { review in
                VStack(alignment: .leading, spacing: 4) {
                    StarRatingView(rating: review.rating)
                        .foregroundColor(.orange)
                    Text("\(review.content)")
                    Text("\(review.user.firstName)")
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .onAppear {
                    Task {
                        try await reviewViewModel.getReviews(from: review.activity, from: review.user)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

//LazyVStack(alignment: .leading, spacing: 8) {
//    Text("Customer Reviews")
//        .font(.system(size: 16, weight: .bold))
//    ForEach(reviewViewModel.review, id: \.id) { review in
//
//        VStack(alignment: .leading, spacing: 4) {
//            ForEach(userViewModel.users, id: \.self) { user in
//                if review.userID == user.id {
//                    Text(user.firstName)
//
//                }
//            }
//            .onAppear{
//                Task {
//                    userViewModel.users = try await userViewModel.getUsers()
//                }
//            }
//            StarRatingView(rating: review.rating)
//                .foregroundColor(.orange)
//            Text("\(review.content)")
//
//        }
//        .padding()
//        .background(Color.white.opacity(0.1))
//        .cornerRadius(8)
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
//        )
//    }
//
//}
//.padding(.horizontal)
