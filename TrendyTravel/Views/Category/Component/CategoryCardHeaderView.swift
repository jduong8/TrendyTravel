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
        CategoryCardHeaderView(activity: .initial)
    }
}
