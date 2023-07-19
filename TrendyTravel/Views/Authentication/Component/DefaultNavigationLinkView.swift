//
//  DefaultNavigationLinkView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import SwiftUI

struct DefaultNavigationLinkView: View {
    @Environment(\.authenticationButton) var style
    @State private var authentication: AuthenticationType
    let action: () -> Void

    init(_ authentication: AuthenticationType, action: @escaping () -> Void) {
        self._authentication = State(initialValue: authentication)
        self.action = action
    }

    var body: some View {
        HStack {
            Text(authentication.style.defaultLink)
            Button {
                action()
            } label: {
                Text("here")
                    .underline()
                    .bold()
            }
        }
    }
}

struct DefaultNavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(AuthenticationType.allCases, id: \.self) {
                DefaultNavigationLinkView($0, action: { })
            }
        }
    }
}
