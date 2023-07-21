//
//  ModifyUserView.swift
//  TrendyTravel
//
//  Created by Cynthia on 21/07/2023.
//

import SwiftUI

struct ModifyUserView: View {
    @ObservedObject var authenticationVM: AuthenticationViewModel
    @ObservedObject var vm: UserViewModel
    var body: some View {
        VStack(alignment: .center) {
            Form {
                AsyncImage(
                    url: URL(string: vm.user.profilImage),
                    content: { image in
                        image.resizable()
                            .scaledToFill()
                            .clipped()
                        
                    },
                    placeholder: {
                        ProgressView()
                    })
                .frame(height: 150)
                Spacer()
                Section {
                    TextField("Username", text: $vm.user.pseudo)
                    TextField("First name", text: $vm.user.firstName)
                    TextField("Last name", text: $vm.user.lastName)
                    TextField("Email", text: $vm.user.email)
                        .keyboardType(.emailAddress)
                } header: {
                    Text("Personnal Information")
                }
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                
                .disabled(authenticationVM.disabledCreateButton())
                .opacity(authenticationVM.opacityCreateButton())
                .buttonStyle(.borderless)
                .listRowBackground(Color.clear)
            }
            Button {
                Task {
                    try await vm.updateUser(userUpdate: vm.user)
                }
            } label: {
                Capsule()
                    .fill(Color.cyan)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .overlay(alignment: .center) {
                        Text("register")
                            .foregroundColor(.white)
                            .bold()
                    }
            }
            .padding()
        }
        .navigationTitle("Modify")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ModifyUserView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyUserView(authenticationVM: AuthenticationViewModel(), vm: UserViewModel())
    }
}
