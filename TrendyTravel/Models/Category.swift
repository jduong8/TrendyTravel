//
//  Category.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation

enum Category: String, CaseIterable, Codable {
    case culture
    case spectacle
    case sport
    case restaurant
    case bar

    var image: String {
        switch self {
        case .culture:
            return "books.vertical.fill"
        case .spectacle:
            return "music.mic"
        case .sport:
            return "sportscourt.fill"
        case .restaurant:
            return "fork.knife"
        case .bar:
            return "wineglass.fill"
        }
    }
}
