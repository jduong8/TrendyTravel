//
//  Follower.swift
//  TrendyTravel
//
//  Created by Cynthia on 18/07/2023.
//

import Foundation

struct Follower: Codable, Hashable {
    var followerId: Int
    var followedId: Int
}
