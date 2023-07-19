//
//  SearchForDestinationView.swift
//  TrendyTravel
//
//  Created by Dina RAZAFINDRATSIRA on 19/07/2023.
//

import SwiftUI

struct SearchForDestinationView: View {
    @ObservedObject var destinationViewModel: DestinationViewModel
    @State var search: String = ""
    @State var filteredDestinations: [Destination] = []
    
    var body: some View {
            VStack {
                if search != "" {
                    ForEach(filteredDestinations, id: \.id) { destination in
                        NavigationLink {
                            PopularDestinationsDetailsView(destination: destination)
                        } label: {
                            PopularDestinationTile(destination: destination)
                        }
                    }
                } else {
                    VStack {
                        PopularDestinationsView(viewModel: destinationViewModel)
                            .onAppear {
                                destinationViewModel
                                    .getPopularDestinations()
                            }
                        PopularActivitiesView()
                        TrendingCreatorsView()
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.top, 32)
                }
            }
        .searchable(text: $search,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search for a destination")
        .onChange(of: search) { newValue in
            filterDestinations()
        }
        .task {
            destinationViewModel.getAllDestinations()
            filterDestinations()
        }
    }
    
    func filterDestinations() {
        filteredDestinations = destinationViewModel.destinations.filter { destination in
            let searchTerm = search.lowercased()
            let cityNameContainsSearchTerm = destination.city.lowercased().contains(searchTerm)
            let countryNameContainsSearchTerm = destination.country.lowercased().contains(searchTerm)
            return cityNameContainsSearchTerm || countryNameContainsSearchTerm
        }
    }
}


struct SearchForDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchForDestinationView(destinationViewModel: DestinationViewModel())
    }
}
