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

    enum CodingKeys: String, CodingKey {
        case id, content, rating
        case userID = "userId"
        case activityID = "activityId"
    }
}
