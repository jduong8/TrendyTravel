//
//  CustomMapAnnotation.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct CustomMapAnnotation: View {
    let attraction: AttractionModel
    var body: some View {
        VStack {
            Image(attraction.imageName)
                .resizable()
                .frame(width: 50, height: 30)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.5)))
                )
            Text(attraction.name)
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
        CustomMapAnnotation(attraction: .init(name: "", imageName: "", latitude: 0.0, longitude: 0.0))
    }
}
