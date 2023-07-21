//
//  AllPopularActivitiesView.swift
//  TrendyTravel
//
//  Created by Tatiana Simmer on 21/07/2023.
//

import Foundation

import SwiftUI

struct AllPopularActivitiesView: View {
    @EnvironmentObject var activityDetailViewModel: ActivityDetailViewModel

    var body: some View {
        List(activityDetailViewModel.activities, id: \.self) { activity in
            NavigationLink(destination: ActivityDetailsView(selectedActivity: activity)) {
                ActivityTile(activity: activity)
            }
        }
        .navigationBarTitle("Popular Activities", displayMode: .inline)
    }
}
