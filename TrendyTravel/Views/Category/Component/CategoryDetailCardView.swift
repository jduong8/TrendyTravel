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
        VStack(spacing: 0) {
            CategoryCardHeaderView(activity: activity)
            CategoryCardFooterView(activity: activity)
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
