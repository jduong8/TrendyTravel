//
//  AddReviewView.swift
//  TrendyTravel
//
//  Created by Dina RAZAFINDRATSIRA on 20/07/2023.
//

import SwiftUI

struct AddReviewView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var reviewViewModel: ActivityReviewViewModel
    
    var body: some View {
        VStack (spacing: 25){
            Text("How would you rate your experience?")
                .font(.title3)
                .foregroundColor(.secondary)
            
            StarRatingButtonView(rating: $reviewViewModel.review.rating)
            
            TextField(
                "Add your comment here..",
                text: $reviewViewModel.review.content
            )
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            Button(action: {
                Task {
                    try await reviewViewModel.addCreatedReview(review:reviewViewModel.review)
                }
                dismiss()
            }) {
                Text("Add a review")
                    .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            .accentColor(.cyan)
        }
        .padding()
    }
}


struct StarRatingButtonView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Button(action: {
                    rating = index + 1
                }) {
                    Image(systemName: index < rating ? "star.fill" : "star")
                        .foregroundColor(index < rating ? .yellow : .gray)
                        .font(.title)
                }
            }
        }
    }
}

