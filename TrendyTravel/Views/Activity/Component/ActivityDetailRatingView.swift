//
//  ActivityDetailRatingView.swift
//  TrendyTravel
//
//  Created by Tatiana Simmer on 19/07/2023.
//

import SwiftUI

struct StarRatingView: View {

    let rating: Int
    
    var body: some View {
        HStack {
            ForEach(0..<rating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
            }
        }
    }
}
