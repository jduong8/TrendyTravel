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
    var destination: Destination?
    
    enum CodingKeys: String, CodingKey {
        case id, category, name, imageName, link, price, latitude, longitude, description, rating, destinationId
        case destination = "Destination"
    }
    
    static let initial = Activity(id: 0, category: "Culture", name: "Effet tower", imageName: "", link: "", price: "", latitude: 0.0, longitude: 0.0, description: "", rating: 0, destinationId: 0, destination: .initial)
}
