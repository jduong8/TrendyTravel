//
//  AllDestinationsView.swift
//  TrendyTravel
//
//  Created by Dina RAZAFINDRATSIRA on 18/07/2023.
//

import SwiftUI

struct AllDestinationsView: View {
    @ObservedObject var viewModel: DestinationViewModel
    
    var body: some View {
        ScrollView {
           VStack{
                ForEach(viewModel.destinations, id: \.self) { destination in
                    NavigationLink {
                        PopularDestinationsDetailsView(destination: destination)
                    } label: {
                        DestinationTileView(destination: destination)
                    }

                    
                }
            }
            .padding()
            .onAppear {
                viewModel.getAllDestinations()
            }
        }
    }
}

struct AllDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        AllDestinationsView(viewModel: DestinationViewModel())
    }
}
