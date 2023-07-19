//
//  PopularActivitiesView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct PopularActivitiesView: View {
    @EnvironmentObject var activity: ActivityDetailViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Popular Activities")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            .onAppear {
                Task {
                    activity.activity = try await activity.getActivities()
                }
            }
            .padding(.horizontal)
            .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(activity.activity, id: \.self) { activity in
                        NavigationLink {
                            ActivityDetailsView(activity: activity)
                        } label: {
                            ActivityTile(activity: activity)
                                .foregroundColor(Color(.label))
                        }
                        .frame(width: 240)
                        .padding(.bottom)
                    }
                    
                }
                
                .padding(.horizontal)
            }
        }
    }
}

struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularActivitiesView().environmentObject(ActivityDetailViewModel())
    }
}
