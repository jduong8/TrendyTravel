//
//  LoginView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import SwiftUI

struct LoginView: View {

    @ObservedObject var authenticationVM: AuthenticationViewModel
    @State private var isSecured: Bool = true

    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 300))
                .foregroundColor(.cyan)
            emailField()
            passwordField()
            AuthenticationButtonView(.login) {
                
            }
            .padding(.top)
            DefaultNavigationLinkView(.login) {
                self.authenticationVM.authenticationType = .register // navigate to RegisterView
                self.authenticationVM.user = .initial // reset all input
            }
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authenticationVM: .init())
    }
}

extension LoginView {
    func emailField() -> some View {
        TextField("email address", text: $authenticationVM.user.email)
            .padding()
            .background (
                Capsule()
                    .stroke(Color.cyan, lineWidth: 2)
            )
    }
    func passwordField() -> some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField("New password", text: $authenticationVM.user.password)
                        .padding()
                        .background (
                            Capsule()
                                .stroke(Color.cyan, lineWidth: 2)
                        )
                } else {
                    TextField("New password", text: $authenticationVM.user.password)
                        .padding()
                        .background (
                            Capsule()
                                .stroke(Color.cyan, lineWidth: 2)
                        )
                }
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .accentColor(.gray)
                }
                .padding(.trailing, 4)
            }
        }
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .padding(.vertical, 5)
    }
}
