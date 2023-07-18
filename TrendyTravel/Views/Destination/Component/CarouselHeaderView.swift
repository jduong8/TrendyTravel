//
//  CarouselHeaderView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct CarouselHeaderView: View {
    @State private var index = 0
    var images: [String]
    var body: some View {
        VStack {
            TabView(selection: $index)  {
                ForEach(Array(zip(images.indices, images)), id: \.0) { index, image in
                    CarouselCustomBackground(imageName: image).tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            HStack(spacing: 2) {
                ForEach((0..<images.count), id: \.self) { index in
                    Rectangle()
                        .fill(index == self.index ? Color.cyan : Color.cyan.opacity(0.5))
                        .frame(width: 30, height: 5)
                }
            }
            .padding()
        }
    }
}

struct CarouselHeaderView_Previews: PreviewProvider {
    static let attractionsImages: [String] = [
        .init("eiffel_tower"),
        .init("new_york"),
        .init("art2"),
        .init("art1")
    ]
    
    static var previews: some View {
        CarouselHeaderView(images: attractionsImages)
            .frame(height: 300)
    }
}
