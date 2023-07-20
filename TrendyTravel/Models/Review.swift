//
//  Review.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation

struct Review: Codable, Hashable {
    var id: Int
    var content: String
    var rating, userID, activityID: Int
    var activity: Activity?
    var user: User?
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, content, rating
        case userID = "userId"
        case activityID = "activityId"
        case activity = "Activity"
        case user = "User"
        case createdAt = "createdAt"
    }
    static let initial = Review(id: 1, content: "", rating: 2, userID: 1, activityID: 1, activity: .initial, user: User(id: 0, firstName: "john", lastName: "doe", description: "hello I'm new", profilImage: "billy", pseudo: "jo.D", password: "kkk", email: "jo.d@gmail.com", posts: [Post(id: 0, title: "1st post", imageName: "eiffel_tower", hashtags: ["paradise", "lost"], userID: 0)], follower: []), createdAt: "2023-07-13T15:56:41.089Z")
    
    // Computed property to format the createdAt date string
    var formattedCreatedAt: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: createdAt) {
            dateFormatter.dateStyle =  .medium
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: date)
        }
        return "Unknown Date"
    }
}
