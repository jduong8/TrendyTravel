//
//  AuthenticationButtonView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import SwiftUI

struct AuthenticationButtonView: View {
    @Environment(\.authenticationButton) var style
    @State private var authentication: AuthenticationType
    let action: () -> Void

    init(_ authentication: AuthenticationType, action: @escaping () -> Void) {
        self._authentication = State(initialValue: authentication)
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Capsule()
                .fill(Color.cyan)
                .frame(maxWidth: style.width)
                .frame(height: 40)
                .overlay(alignment: .center) {
                    Text(authentication.style.defaultLabel)
                        .foregroundColor(.white)
                        .bold()
                }
        }

    }
}

struct AuthenticationButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(AuthenticationType.allCases, id: \.self) {
                AuthenticationButtonView($0, action: { })
                DefaultNavigationLinkView($0, action: {})
            }
        }
    }
}
