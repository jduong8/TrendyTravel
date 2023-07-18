//
//  CategoriesView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var destinationVM: DestinationViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(Category.allCases, id: \.self) { category in
                    NavigationLink {
                        CategoryDetailView(name: category.rawValue, destinationVM: destinationVM)
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
                CategoriesView(destinationVM: DestinationViewModel())
            }
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

