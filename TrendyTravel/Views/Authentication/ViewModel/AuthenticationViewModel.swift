//
//  AuthenticationViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var authenticationType: AuthenticationType = .login
    @Published var user: User = .initial

    func createAccount(user: User) {
    }

    func disabledCreateButton() -> Bool {
        if (user.pseudo.isEmpty ||
             user.firstName.isEmpty ||
             user.lastName.isEmpty ||
             user.email.isEmpty ||
             user.password.isEmpty ||
             user.description.isEmpty) {
            return true
        } else {
            return false
        }
    }
    func opacityCreateButton() -> Double {
        if (user.pseudo.isEmpty ||
             user.firstName.isEmpty ||
             user.lastName.isEmpty ||
             user.email.isEmpty ||
             user.password.isEmpty ||
             user.description.isEmpty) {
            return 0.4
        } else {
            return 1
        }
    }
}
