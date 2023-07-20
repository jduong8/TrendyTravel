//
//  DestinationTileView.swift
//  TrendyTravel
//
//  Created by Dina RAZAFINDRATSIRA on 19/07/2023.
//

import SwiftUI

struct DestinationTileView: View {
    let destination: Destination
    
    var body: some View {
        VStack(spacing: 0) {
            if let url = URL(string: destination.imageName) {
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
            }
            RoundedCorners(
                topLeft: 0,
                topRight: 0,
                bottomLeft: 8,
                bottomRight: 8
            )
            .fill(Color.white)
            
            .frame(height: 60)
            .overlay {
                VStack(alignment: .leading, spacing: 4) { // Align to leading edge
                    Text(destination.city)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(destination.country)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
            }
        }
        .shadow(radius: 8)
        .padding()
    }
    
}

struct DestinationTileView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationTileView(destination: .initial)
    }
}
