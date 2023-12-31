//
//  PopularDestinationsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct PopularDestinationsView: View {

    @ObservedObject var viewModel: DestinationViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Popular Destinations")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                NavigationLink {
                    AllDestinationsView(viewModel: viewModel)
                } label: {
                    Text("See all")
                        .font(.system(size: 12, weight: .semibold))
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.destinations, id: \.self) { destination in
                        NavigationLink {
                            DestinationDetailView(destination: destination)
                        } label: {
                            PopularDestinationTile(destination: destination)
                                .padding(.bottom)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DestinationDetailView(destination: .init(id: 1, country: "France", city: "Paris", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235, activities: []))
        }
    }
}
