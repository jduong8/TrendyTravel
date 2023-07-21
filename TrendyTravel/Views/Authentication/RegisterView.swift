//
//  RegisterView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import SwiftUI
import UIKit

struct RegisterView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var authenticationVM: AuthenticationViewModel
    @State private var isSecured: Bool = false
    @State private var image: UIImage? = nil
    @State private var shouldNavigate: Bool = false

    var body: some View {
        VStack(alignment: .center) {
            Form {
                randomImage()
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
                personalInformationForm(user: $authenticationVM.user)
                passwordForm(user: $authenticationVM.user)
                descriptionForm(user: $authenticationVM.user)
                AuthenticationButtonView(.register) {
                    Task {
                        _ = try await authenticationVM.addUser(user: authenticationVM.user)
                    }
                    dismiss()
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
    func randomImage() -> some View {
        // Replace your AsyncImage with this
        Image(uiImage: self.image ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .frame(width: 200, height: 200, alignment: .center)
            .overlay(
                Button {
                    Task {
                        do {
                            self.image = try await self.authenticationVM.loadImage()
                        } catch {
                            print("Failed to load image: \(error)")
                        }
                    }
                } label: {
                    Image(systemName: "shuffle.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.cyan)
                }
                    .buttonStyle(.borderless),
                alignment: .bottomTrailing
            )
    }
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
