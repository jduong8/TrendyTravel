//
//  CategoryDetailView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct CategoryDetailView: View {

    @ObservedObject var vm: CategoryDetailsViewModel
    @ObservedObject var destinationVM: DestinationViewModel

    var body: some View {
        Group {
            if vm.isLoading {
                CategoryDetailLoadingView()
            } else {
                ZStack {
                    if !vm.errorMessage.isEmpty {
                        CategoryDetailErrorView(errorMessage: vm.errorMessage)
                    }
                    ScrollView {
                        ForEach(vm.activities, id: \.self) { activity in
                            CategoryDetailCardView(vm: destinationVM, activity: activity)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(vm.category.rawValue.capitalized, displayMode: .inline)
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailView(vm: CategoryDetailsViewModel(), destinationVM: DestinationViewModel())
        }
    }
}
