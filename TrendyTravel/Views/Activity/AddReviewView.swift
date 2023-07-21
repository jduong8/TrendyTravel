//
//  AddReviewView.swift
//  TrendyTravel
//
//  Created by Dina RAZAFINDRATSIRA on 20/07/2023.
//

import SwiftUI

struct AddReviewView: View {
    @State private var userRating = 0
    @State private var comment: String = ""
    
    var body: some View {
        VStack (spacing: 25){
            Text("How would you rate your experience?")
                .font(.title3)
                .foregroundColor(.secondary)
            
            StarRatingButtonView(rating: $userRating)
            //                Text("Your rating: \(userRating) stars")
            
            TextField(
                "Add your comment here..",
                text: $comment
            )
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            Button {
                // TODO: Handle the button action here
            } label: {
                Text("Add a review")
                    .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            .accentColor(.cyan)


        }
        .padding()
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView()
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

