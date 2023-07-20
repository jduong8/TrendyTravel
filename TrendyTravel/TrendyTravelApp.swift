//
//  TrendyTravelApp.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

@main
struct TrendyTravelApp: App {
    @StateObject var userVm = UserViewModel()
    @StateObject var activityVM = ActivityDetailViewModel()
    @StateObject var destinationViewModel = DestinationViewModel()

    var body: some Scene {
        WindowGroup {
            DiscoverDestinationsView(destinationViewModel: destinationViewModel)
                .environmentObject(userVm)
                .environmentObject(activityVM)
                .environmentObject(destinationViewModel)
        }
    }
}
