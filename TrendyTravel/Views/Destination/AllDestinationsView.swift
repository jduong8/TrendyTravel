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
            ForEach(viewModel.destinations, id: \.self) { destination in
                Text(destination.city)
                    .onAppear {
                        viewModel.getAllDestinations()
                    }
            }
        }
    }
}

struct AllDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        AllDestinationsView(viewModel: DestinationViewModel())
    }
}
