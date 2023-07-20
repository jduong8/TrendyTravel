//
//  TrendingCreatorsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct TrendingCreatorsView: View {
    @EnvironmentObject var vm : UserViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Trending Creators")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                NavigationLink {
                    UsersListView(vm: vm)
                } label: {
                    Text("See all")
                        .font(.system(size: 12, weight: .semibold))
                }
            }
            .padding(.top)
            .onAppear {
                Task {
                    vm.users = try await vm.getUsers()
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 40) {
                    ForEach(vm.users, id: \.self) { user in
                        NavigationLink {
                            UserDetailsView(vm: vm, user: user)
                        } label: {
                            DiscoverUserView(user: user)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
}

struct TrendingCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TrendingCreatorsView()
                .environmentObject(UserViewModel())
        }
    }
}
