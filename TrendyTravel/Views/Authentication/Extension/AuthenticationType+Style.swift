//
//  AuthenticationType+Style.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import Foundation

extension AuthenticationType {
    var style: AuthenticationButtonStyling {
        switch self {
        case .login:
            return LoginButton()
        case .register:
            return CreateAccountButton()
        }
    }
}
