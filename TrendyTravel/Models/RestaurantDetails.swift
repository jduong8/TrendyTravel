//
//  RestaurantDetails.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation

struct RestaurantDetails: Codable, Hashable {
    var id = UUID()
    let description: String
    let photos: [String]
    let reviews: [Review]
}
