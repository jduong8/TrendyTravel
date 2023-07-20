//
//  AuthenticationView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import SwiftUI

struct AuthenticationView: View {

    @ObservedObject var authenticationVM: AuthenticationViewModel

    @ViewBuilder
    var body: some View {
        switch authenticationVM.authenticationType {
        case .login:
            LoginView(authenticationVM: authenticationVM)
        case .register:
            RegisterView(authenticationVM: authenticationVM)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(authenticationVM: .init())
    }
}
