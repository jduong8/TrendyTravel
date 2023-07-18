//
//  Destinations.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import Foundation

struct Destination: Codable, Hashable {
    var id: Int
    var country, city, imageName: String
    var latitude, longitude: Double
}
