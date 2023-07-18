//
//  CategoryCardFooterView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 18/07/2023.
//

import SwiftUI

struct CategoryCardFooterView: View {
    
    let activity: Activity
    
    var body: some View {
        RoundedCorners(
            topLeft: 0,
            topRight: 0,
            bottomLeft: 8,
            bottomRight: 8
        )
        .fill(Color.white)
        .shadow(radius: 8)
        .frame(height: 60)
        .overlay {
            cardInformation()
        }
    }
}

struct CategoryCardFooterView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardFooterView(activity:
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

extension CategoryCardFooterView {
    func cardInformation() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(activity.name)
                    .font(.system(
                        size: 12,
                        weight: .semibold
                    ))
                Text(activity.destination.city.capitalized)
                    .font(.system(
                        size: 10,
                        weight: .semibold
                    ))
                Text(activity.destination.country.capitalized)
                    .foregroundColor(.gray)
                    .font(.system(
                        size: 10,
                        weight: .semibold
                    ))
            }
            .padding(.leading, 8)
            Spacer()
            Capsule()
                .fill(.cyan)
                .opacity(0.2)
                .overlay {
                    Text(activity.category.capitalized)
                        .foregroundColor(.cyan)
                        .bold()
                }
                .frame(width: 100, height: 20)
                .padding(.trailing)
        }
    }
}
