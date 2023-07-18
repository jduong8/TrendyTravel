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
            AsyncImage(
                url: URL(string: activity.imageName),
                content: { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                },
                placeholder: {
                    ProgressView()
                }
            )
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
                    Text("\(activity.rating)")
                }
                Text("\(activity.destination.city), \(activity.destination.country)")
            }
            .font(.system(size: 12, weight: .semibold))
            Spacer()
        }
    }
}

struct RestaurantTile_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTile(activity: .initial)
    }
}
