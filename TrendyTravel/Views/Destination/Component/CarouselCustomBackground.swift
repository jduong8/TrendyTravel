//
//  CarouselCustomBackground.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct CarouselCustomBackground: View {
    let imageName: String
    var body: some View {
        AsyncImage(url: URL(string: imageName)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
            @unknown default:
                Text("Unknown image loading error")
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 250) // Set the frame size accordingly
    }
}

struct CarouselCustomBackground_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCustomBackground(imageName: "eiffel_tower")
    }
}
