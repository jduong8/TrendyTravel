//
//  CategoriesView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct CategoriesView: View {

    @StateObject var activityVM = ActivityViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(Category.allCases, id: \.self) { category in
                    NavigationLink {
                        ActivitiesListView(activityVM: activityVM)
                            .onAppear {
                                Task {
                                   try await self.activityVM.getActivities(from: category)
                                }
                            }
                    } label: {
                        CategoriesIconsView(category: category)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color.cyan
                CategoriesView()
            }
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

