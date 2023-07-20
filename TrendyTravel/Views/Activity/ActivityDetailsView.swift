//
//  ActivityDetailsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 29/06/2023.
//

import SwiftUI

struct ActivityDetailsView: View {

    @StateObject private var reviewViewModel: ActivityReviewViewModel

    init(selectedActivity: Activity) {
        self._reviewViewModel = StateObject(wrappedValue: ActivityReviewViewModel(selectedActivity: selectedActivity))
    }

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(
                    url: URL(string: reviewViewModel.selectedActivity.imageName),
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
                        Text(reviewViewModel.selectedActivity.name)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                        HStack {
                            StarRatingView(rating: reviewViewModel.selectedActivity.rating)
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
                if let activity = reviewViewModel.selectedActivity.destination {
                    Text("\(activity.city.capitalized), \(activity.country.capitalized)")
                }
                HStack {
                    Text(reviewViewModel.selectedActivity.price)
                }
                .foregroundColor(.orange)
                HStack { Spacer()}
            }
            .padding(.top)
            .padding(.horizontal)
            Text(reviewViewModel.selectedActivity.description)
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
            ActivityDetailsView(selectedActivity: .initial)
        }
    }
}
