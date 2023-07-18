//
//  Activity.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation

struct Activity: Codable, Hashable, Identifiable {
    var id: Int
    var category, name, imageName: String
    var link: String
    var price: String
    var latitude, longitude: Double
    var description: String
    var rating, destinationId: Int

    enum CodingKeys: String, CodingKey {
        case id, category, name, imageName, link, price, latitude, longitude, description, rating, destinationId
    }
}
