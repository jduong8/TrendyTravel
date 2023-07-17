//
//  CategoriesView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct CategoriesView: View {
    let categories: [Category] = [
        .init(name: "Culture", imageName: "books.vertical.fill"),
        .init(name: "Spectacles", imageName: "music.mic"),
        .init(name: "Sports", imageName: "sportscourt.fill"),
        .init(name: "Restaurant", imageName: "fork.knife"),
        .init(name: "Bar", imageName: "wineglass.fill"),
    ]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(categories, id: \.self) { category in
                    NavigationLink {
                        CategoryDetailView(name: category.name)
                    } label: {
                        CategoriesIconsView(image: category.imageName, title: category.name)
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

