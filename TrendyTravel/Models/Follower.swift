//
//  Follower.swift
//  TrendyTravel
//
//  Created by Cynthia on 18/07/2023.
//

import Foundation

struct Follower: Codable, Hashable {
    let id, followerID, followedID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case followerID = "followerId"
        case followedID = "followedId"
    }
}
