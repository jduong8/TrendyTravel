//
//  CategoryDetailCardView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct CategoryDetailCardView: View {
    let activity: ActivityModel
    
    var destination: DestinationModel {
        for destination in  DestinationViewModel().destinations {
            if   activity.destinationId == destination.id {
                return destination
            }
        }
        return self.destination
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(activity.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(activity.name)
                .font(.system(size: 12, weight: .semibold))
                .padding()
        }
        .padding()
    }
}


struct CategoryDetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailCardView(activity:
                .init(
                    id: 0,
                    category: "",
                    name: "",
                    imageName: "",
                    link: "",
                    price: "",
                    latitude: 0.0,
                    longitude: 0.0,
                    description: "",
                    rating: 0,
                    destinationId: 0
                )
        )
    }
}
