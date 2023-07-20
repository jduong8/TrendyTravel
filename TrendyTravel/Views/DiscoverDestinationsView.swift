//
//  DiscoverDestinationsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct DiscoverDestinationsView: View {

    @StateObject var destinationViewModel = DestinationViewModel()
    @ObservedObject var authenticationVM: AuthenticationViewModel

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.cyan, .mint]), startPoint: .top,
                               endPoint: .center)
                .ignoresSafeArea()
                Color.white
                    .offset(y: 400)
                ScrollView(showsIndicators: false) {
                    CategoriesView()
                    SearchForDestinationView(destinationViewModel: destinationViewModel)
                }
                .navigationTitle("Discover")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            AuthenticationView(authenticationVM: authenticationVM)
                        } label: {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 30))
                        }
                    }
                }
            }
        }
    }
}

struct DestinationsListView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverDestinationsView(authenticationVM: .init())
            .colorScheme(.light)
            .environmentObject(UserViewModel())
            .environmentObject(ActivityViewModel())
        DiscoverDestinationsView(authenticationVM: .init())
            .colorScheme(.dark)
            .environmentObject(UserViewModel())
            .environmentObject(ActivityViewModel())
    }
}
