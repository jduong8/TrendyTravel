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
    var activity: Activity
    var user: User

    enum CodingKeys: String, CodingKey {
        case id, content, rating
        case userID = "userId"
        case activityID = "activityId"
        case activity = "Activity"
        case user = "User"
    }
    static let initial = Review(id: 1, content: "", rating: 2, userID: 1, activityID: 1, activity: .initial, user: User(id: 0, firstName: "john", lastName: "doe", description: "hello I'm new", profilImage: "billy", pseudo: "jo.D", password: "kkk", email: "jo.d@gmail.com", posts: [Post(id: 0, title: "1st post", imageName: "eiffel_tower", hashtags: ["paradise", "lost"], userID: 0)], follower: []))
}
