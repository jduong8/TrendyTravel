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
    var followers: [Follower]?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case description, profilImage, pseudo, password, email
        case posts = "Posts"
        case followers = "Followers"

    }
    static let initial = User(id: 0, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 0, title: "", imageName: "", hashtags: [], userID: 0)], follower: [])
}
