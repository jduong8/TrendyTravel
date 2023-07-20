//
//  ActivityDetailsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 29/06/2023.
//

import SwiftUI

struct ActivityDetailsView: View {
    let activity: Activity
    @StateObject private var reviewViewModel = ActivityReviewViewModel()
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(
                    url: URL(string: activity.imageName),
                    content: { image in
                        image
                            .resizable()
                            .frame(height: 200)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(activity.name)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                        HStack {
                            StarRatingView(rating: activity.rating)
                                .font(.title2)
                                .foregroundColor(.orange)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Location & Description")
                    .font(.system(size: 16, weight: .bold))
                Text("\(activity.destination?.city.capitalized ?? "Unknown City"), \(activity.destination?.country.capitalized ?? "Unknown Country")")
                HStack {
                    Text(activity.price)
                }
                .foregroundColor(.orange)
                HStack { Spacer()}
            }
            .padding(.top)
            .padding(.horizontal)
            Text(activity.description)
                .padding(.top, 8)
                .font(.system(size: 14, weight: .regular))
                .padding(.horizontal)
                .padding(.bottom)
            Divider()
                .padding(.horizontal)
            ScrollView {
                ActivityReviewsView(reviewViewModel: reviewViewModel)
            }
        }
        .navigationBarTitle("Activity Details", displayMode: .inline)
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActivityDetailsView(activity: .initial)
        }
    }
}
