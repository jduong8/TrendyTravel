//
//  Post.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 29/06/2023.
//

import Foundation

struct Post: Codable, Hashable {
    var id: Int
    var title, imageName: String
    var hashtags: [String]
    var userID: Int
    var likes: [Like]?

    enum CodingKeys: String, CodingKey {
        case id, title, imageName, hashtags
        case userID = "userId"
        case likes = "Likes"
    }
}

