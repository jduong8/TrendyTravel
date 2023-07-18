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
        Image(imageName)
            .resizable()
            .scaledToFill()
    }
}

struct CarouselCustomBackground_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCustomBackground(imageName: "eiffel_tower")
    }
}
