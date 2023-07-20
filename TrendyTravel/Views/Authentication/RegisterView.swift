//
//  RegisterView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import SwiftUI

struct RegisterView: View {

    @ObservedObject var authenticationVM: AuthenticationViewModel
    @State private var isSecured: Bool = false

    var body: some View {
        VStack(alignment: .center) {
            Form {
                personalInformationForm(user: $authenticationVM.user)
                passwordForm(user: $authenticationVM.user)
                descriptionForm(user: $authenticationVM.user)
                AuthenticationButtonView(.register) {
                }
                .disabled(authenticationVM.disabledCreateButton())
                .opacity(authenticationVM.opacityCreateButton())
                .buttonStyle(.borderless)
                .listRowBackground(Color.clear)
            }
            .overlay(alignment: .bottom) {
                DefaultNavigationLinkView(.register) {
                    self.authenticationVM.authenticationType = .login // Navigate to LoginView
                    self.authenticationVM.user = .initial // reset all input
                }
            }
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(authenticationVM: .init())
    }
}

extension RegisterView {
    func personalInformationForm(user: Binding<User>) -> some View {
        Section {
            TextField("Username", text: user.pseudo)
            TextField("First name", text: user.firstName)
            TextField("Last name", text: user.lastName)
            TextField("Email", text: user.email)
                .keyboardType(.emailAddress)
        } header: {
            Text("Personnal Information")
        }
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
    }

    func passwordForm(user: Binding<User>) -> some View {
        Section {
            ZStack(alignment: .trailing) {
                Group {
                    if !isSecured {
                        SecureField("New password", text: user.password)
                    } else {
                        TextField("New password", text: user.password)
                    }

                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: !self.isSecured ? "eye.slash" : "eye")
                            .accentColor(.gray)
                    }
                }
            }
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
        } header: {
            Text("Password")
        }
    }

    func descriptionForm(user: Binding<User>) -> some View {
        Section {
            TextEditor(text: user.description)
        } header: {
            Text("Description")
        }

    }
}
