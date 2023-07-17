//
//  ReviewUser.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation

struct ReviewUser: Codable, Hashable {
    let id: Int
    let username, firstName, lastName, profileImage: String
}
