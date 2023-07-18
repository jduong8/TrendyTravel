//
//  CategoryCardHeaderView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 18/07/2023.
//

import SwiftUI

struct CategoryCardHeaderView: View {

    let activity: Activity

    var body: some View {
        if let url = URL(string: activity.imageName) {
            AsyncImage(url: url) { state in
                switch state {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                default:
                    ProgressView()
                }
            }
            .clipShape(
                RoundedCorners(
                    topLeft: 8,
                    topRight: 8,
                    bottomLeft: 0,
                    bottomRight: 0
                )
            )
            .shadow(radius: 8)
        }
    }
}

struct CategoryCardHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardHeaderView(activity:
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
                    destinationId: 0,
                    destination: .init(
                        id: 0,
                        country: "",
                        city: "",
                        imageName: "",
                        latitude: 0.0,
                        longitude: 0.0
                    )
                )
        )
    }
}
