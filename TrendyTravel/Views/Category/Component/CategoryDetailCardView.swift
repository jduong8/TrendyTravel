//
//  CategoryDetailCardView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct CategoryDetailCardView: View {
    
    let activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let url = URL(string: activity.imageName) {
                AsyncImage(url: url) { state in
                    switch state {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    default:
                        ProgressView()
                    }
                }
                Text(activity.name)
                    .font(.system(size: 12, weight: .semibold))
                    .padding()
            }
        }
        .padding()
    }
}

struct CategoryDetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailCardView(activity:
                .init(
                    id: 0,
                    category: "",
                    name: "",
                    imageName: "",
                    link: "",
                    price: "",
                    latitude: 0.0,
                    longitude: 0.0,
                    description: "",
                    rating: 0,
                    destinationId: 0
                )
        )
    }
}
