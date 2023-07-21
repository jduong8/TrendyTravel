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
            ForEach(reviewViewModel.reviews, id: \.id) { review in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        AsyncImage(
                            url: URL(string: review.user?.profilImage ?? ""),
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44)
                                    .clipShape(Circle())
                            },
                            placeholder: {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44)
                                    .clipShape(Circle())
                            }
                        )
                        VStack(alignment: .leading, spacing: 4) {
                            if let user = review.user {
                                Text("\(user.firstName) \(user.lastName)")
                                    .font(.system(size: 14,weight: .bold))
                            }
                            StarRatingView(rating: review.rating)
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        Text(review.formattedCreatedAt)
                            .font(.system(size: 14, weight: .bold))
                    }
                    Text("\(review.content)")
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
        }
        .padding(.horizontal)
    }
}
