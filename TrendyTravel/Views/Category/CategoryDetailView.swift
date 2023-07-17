//
//  CategoryDetailView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct CategoryDetailView: View {
    let name: String
    @EnvironmentObject var vm: CategoryDetailsViewModel
    
    var body: some View {
        if vm.isLoading {
            CategoryDetailLoadingView()
        } else {
            ZStack {
                if !vm.errorMessage.isEmpty {
                    CategoryDetailErrorView(errorMessage: vm.errorMessage)
                }
                ScrollView {
                    ForEach(vm.activities, id: \.self) { activity in
                        CategoryDetailCardView(activity: activity)
                            .navigationBarTitle(activity.category.capitalized, displayMode: .inline)
                    }
                }
            }
            
        }
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailView(name: "culture")
                .environmentObject(CategoryDetailsViewModel())
        }
    }
}
