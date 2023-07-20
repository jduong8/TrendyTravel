//
//  Users.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import Foundation

struct User: Codable, Hashable {
    var id: Int
    var firstName, lastName, description, profilImage: String
    var pseudo, password, email: String
    var posts: [Post]?
    var follower: [Follower]?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case description, profilImage, pseudo, password, email
        case posts = "Posts"
        case follower = "Followers"

    }
}
