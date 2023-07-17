//
//  CategoryDetailErrorView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct CategoryDetailErrorView: View {
    let errorMessage: String
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "xmark.octagon.fill")
                .font(.system(size: 64, weight: .semibold))
                .foregroundColor(.red)
            Text(errorMessage)
        }
    }
}


struct CategoryDetailErrorView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailErrorView(errorMessage: "")
    }
}
