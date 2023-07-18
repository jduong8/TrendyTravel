//
//  DiscoverDestinationsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct DiscoverDestinationsView: View {

    @StateObject var destinationViewModel = DestinationViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.cyan, .mint]), startPoint: .top,
                               endPoint: .center)
                .ignoresSafeArea()
                Color.white
                    .offset(y: 400)
                ScrollView(showsIndicators: false) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Where do you want to go?")
                        Spacer()
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.3)))
                    .cornerRadius(10)
                    .padding(16)
                    CategoriesView()
                        VStack {
                            PopularDestinationsView(viewModel: destinationViewModel)
                                .onAppear {
                                    destinationViewModel
                                        .getDestinations()
                                }
                            PopularActivitiesView()
                            TrendingCreatorsView()
                        }
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.top, 32)
                    }
                
                .navigationTitle("Discover")
            }
        }
    }
}

struct DestinationsListView_Previews: PreviewProvider {
//    @EnvironmentObject var userVm = UserViewModel()
    static var previews: some View {
        DiscoverDestinationsView()
            .colorScheme(.light)
            .environmentObject(UserViewModel())
            .environmentObject(DestinationViewModel())
            .environmentObject(ActivityViewModel())
        DiscoverDestinationsView()
            .colorScheme(.dark)
            .environmentObject(UserViewModel())
            .environmentObject(DestinationViewModel())
            .environmentObject(ActivityViewModel())
    }
}
