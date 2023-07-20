//
//  Like.swift
//  TrendyTravel
//
//  Created by Cynthia on 19/07/2023.
//

import Foundation

struct Like: Codable, Hashable {
    let id, postID, userID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case postID = "postId"
        case userID = "userId"
    }
}
