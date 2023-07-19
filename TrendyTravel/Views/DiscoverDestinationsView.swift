//
//  DiscoverDestinationsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct DiscoverDestinationsView: View {
    @ObservedObject var destinationViewModel: DestinationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.cyan, .mint]), startPoint: .top,
                               endPoint: .center)
                .ignoresSafeArea()
                Color.white
                    .offset(y: 400)
                ScrollView(showsIndicators: false) {
                    SearchForDestinationView(destinationViewModel: destinationViewModel)
                    CategoriesView()
                    VStack {
                        PopularDestinationsView(viewModel: destinationViewModel)
                            .onAppear {
                                destinationViewModel
                                    .getPopularDestinations()
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
        DiscoverDestinationsView(destinationViewModel: DestinationViewModel())
            .colorScheme(.light)
            .environmentObject(UserViewModel())
            .environmentObject(DestinationViewModel())
            .environmentObject(ActivityViewModel())
        DiscoverDestinationsView(destinationViewModel: DestinationViewModel())
            .colorScheme(.dark)
            .environmentObject(UserViewModel())
            .environmentObject(DestinationViewModel())
            .environmentObject(ActivityViewModel())
    }
}
