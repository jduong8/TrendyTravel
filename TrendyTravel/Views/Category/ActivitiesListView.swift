//
//  ActivitiesListView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct ActivitiesListView: View {

    @ObservedObject var activityVM: ActivityViewModel
    
    var body: some View {
        VStack {
            if activityVM.activities.isEmpty {
                ProgressView()
            } else {
                ScrollView {
                    ForEach(activityVM.activities, id: \.self) { activity in
                        CategoryDetailCardView(activity: activity)
                    }
                }
            }
        }
        .navigationBarTitle(activityVM.category.rawValue.capitalized, displayMode: .inline)
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActivitiesListView(activityVM: ActivityViewModel())
        }
    }
}
