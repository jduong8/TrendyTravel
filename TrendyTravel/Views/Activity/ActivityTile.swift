//
//  ActivityTile.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct ActivityTile: View {
    let activity: Activity
    var body: some View {
        HStack(spacing: 8) {
            AsyncImage(url: URL(string: activity.imageName))
//                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(5)
//                .padding(.leading, 6)
//                .padding(.vertical, 6)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(activity.name)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Image(systemName: "star.fill")
                    Text("4.7")
                }
                Text("Tokyo, Japan")
            }
            .font(.system(size: 12, weight: .semibold))
            Spacer()
        }
    }
}

struct RestaurantTile_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTile(activity: Activity(id: 0, category: "", name: "", imageName: "", link: "", price: "", latitude: 0.0, longitude: 0.0, description: "", rating: 4, destinationId: 3))
    }
}
