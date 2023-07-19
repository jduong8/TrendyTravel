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
        VStack {
            Image(activity.imageName)
                .resizable()
                .frame(width: 50, height: 30)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.5)))
                )
            Text(activity.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.mint]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.5)))
                )
        }
        .shadow(radius: 5)
    }
}

struct CustomMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapAnnotation(activity: .init(id: 1, category: "", name: "", imageName: "", link: "", price: "", latitude: 0.0, longitude: 0.0, description: "", rating: 0, destinationId: 1, destination: .initial))
    }
}
