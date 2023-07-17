//
//  CarouselCustomBackground.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct CarouselCustomBackground: View {
    let imageName: String
    let isBlackBackground: Bool
    var body: some View {
        if isBlackBackground {
            ZStack {
                Color.black
                Image(imageName)
                    .resizable()
                    .scaledToFit()
            }
        } else {
            Image(imageName)
                .resizable()
                .scaledToFill()
        }
    }
}

struct CarouselCustomBackground_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCustomBackground(imageName: "", isBlackBackground: false)
    }
}
