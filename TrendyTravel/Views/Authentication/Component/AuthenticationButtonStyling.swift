//
//  AuthenticationButtonStyling.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import SwiftUI

protocol AuthenticationButtonStyling {
    var defaultBackgroundColor: Color { get }
    var defaultLabel: String { get }
    var defaultLink: String { get }
    var width: CGFloat { get }
}

struct LoginButton: AuthenticationButtonStyling {
    let defaultBackgroundColor: Color = .cyan
    let defaultLabel: String = "Connexion"
    let defaultLink: String = "Don't have any account ?"
    let width: CGFloat = .infinity
}

struct CreateAccountButton: AuthenticationButtonStyling {
    let defaultBackgroundColor: Color = .cyan
    let defaultLabel: String = "Create account"
    let defaultLink: String = "Already have an account ?"
    let width: CGFloat = .infinity
}

struct AuthenticationButtonStylingKey: EnvironmentKey {
    static var defaultValue: AuthenticationButtonStyling = LoginButton()
}

extension EnvironmentValues {
    var authenticationButton: AuthenticationButtonStyling {
        get { self[AuthenticationButtonStylingKey.self] }
        set { self[AuthenticationButtonStylingKey.self] = newValue }
    }
}

extension View {
    func style(_ style: AuthenticationButtonStyling) -> some View {
        environment(\.authenticationButton, style)
    }
}
