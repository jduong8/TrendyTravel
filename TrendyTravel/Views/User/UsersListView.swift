//
//  UsersListView.swift
//  TrendyTravel
//
//  Created by Cynthia on 17/07/2023.
//

import SwiftUI

struct UsersListView: View {
    @ObservedObject var vm : UserViewModel
    let column = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: column) {
                ForEach(vm.users, id: \.self) { user in
                    NavigationLink {
                        UserDetailsView(user: user)
                    } label: {
                        DiscoverUserView(user: user)
                    }
                    
                }
                .onAppear {
                    Task {
                        vm.users = try await vm.getUsers()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle("All creators")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UsersListView(vm: UserViewModel())
        }
    }
}
