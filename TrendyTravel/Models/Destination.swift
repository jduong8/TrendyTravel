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
    var activities: [Activity]?
    
    enum CodingKeys: String, CodingKey {
        case id, country, city, imageName, latitude, longitude
        case activities = "Activities"
    }
    
    static let initial = Destination(id: 0, country: "France", city: "Paris", imageName: "", latitude: 0.0, longitude: 0.0, activities: [])
}
