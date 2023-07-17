//
//  DestinationViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation

class DestinationViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var destinations: [Destination] = [
        .init(id: 1, country: "France", city: "Paris", inageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235)
    ]
}
