//
//  ProfilUserView.swift
//  TrendyTravel
//
//  Created by Cynthia on 21/07/2023.
//

import SwiftUI

struct ProfilUserView: View {
    @ObservedObject var authenticationVM: AuthenticationViewModel
    @ObservedObject var vm: UserViewModel
    @State private var isModify: Bool = false
    @State private var isLogOut: Bool = false
    var body: some View {
        VStack {
            ProfilComponentView(user: vm.user, followersNumber: vm.user.followers?.count ?? 0)
            HStack(alignment: .center) {
                Text("My Posts")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
                Button {
                    
                } label: {
                    Text("Add Post")
                        .padding(.horizontal)
                }
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.8), .purple.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
            }
            .padding()
            List {
                if (vm.user.posts != nil) {
                    ForEach(vm.user.posts!, id: \.self) { post in
                        VStack {
                            PostDescriptionView(user: vm.user, post: post)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                
                            } label: {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            }
                            .tint(.indigo)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            NavigationLink(destination: AuthenticationView(authenticationVM: authenticationVM), isActive: $isLogOut) {
                EmptyView()
            }
//            NavigationLink(destination: , isActive: $isModify) {
//                EmptyView()
//            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Modify Profil")
                            Spacer()
                            Image(systemName: "pencil.tip.crop.circle.badge.arrow.forward")
                                .foregroundStyle(.black, .blue)
                        }
                    }
                    Button {
                        isLogOut = true
                    } label: {
                        HStack {
                            Text("Logout")
                            Spacer()
                            Image(systemName: "x.square")
                                .foregroundStyle(.red, .red)
                        }
                    }
                } label: {
                    Text("Profil")
                }
            }
        }
    }
}

struct ProfilUserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfilUserView(authenticationVM: AuthenticationViewModel(), vm: UserViewModel())
        }
    }
}
