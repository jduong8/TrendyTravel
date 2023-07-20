//
//  CustomMapAnnotation.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct CustomMapAnnotation: View {
    let activity: Activity
    var body: some View {
        VStack(spacing: 2) {
            AsyncImage(url: URL(string: activity.imageName)) { phase in
                switch phase {
                case .empty:
                    Color.gray
                        .frame(width: 50, height: 30)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(.init(white: 0, alpha: 0.1)))
                        )
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 50, height: 30)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(.init(white: 0, alpha: 0.1)))
                        )
                case .failure(_):
                    Color.red
                        .frame(width: 50, height: 30)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(.init(white: 0, alpha: 0.1)))
                        )
                @unknown default:
                    Color.red
                        .frame(width: 50, height: 30)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(.init(white: 0, alpha: 0.1)))
                        )
                }
            }

            Text(activity.name)
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.mint]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.init(white: 0, alpha: 0.1)))
                    )
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
        }
        .shadow(radius: 5)
    }
}

struct CustomMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapAnnotation(activity: .init(id: 1, category: "", name: "Big Mama", imageName: "http://res.cloudinary.com/dvo3xgwym/image/upload/v1689611455/l1abswkri70e9jsgdnog.jpg", link: "", price: "", latitude: 0.0, longitude: 0.0, description: "", rating: 0, destinationId: 1, destination: .initial))
    }
}
