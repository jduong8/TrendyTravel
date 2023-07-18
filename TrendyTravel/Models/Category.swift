//
//  Category.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation

enum Category: String, CaseIterable {
    case culture
    case spectacles
    case sports
    case restaurant
    case bar

    var image: String {
        switch self {
        case .culture:
            return "books.vertical.fill"
        case .spectacles:
            return "music.mic"
        case .sports:
            return "sportscourt.fill"
        case .restaurant:
            return "fork.knife"
        case .bar:
            return "wineglass.fill"
        }
    }
}
