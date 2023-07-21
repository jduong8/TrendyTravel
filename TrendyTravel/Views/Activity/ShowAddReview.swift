//
//  ShowAddReview.swift
//  TrendyTravel
//
//  Created by Dina RAZAFINDRATSIRA on 21/07/2023.
//

import SwiftUI

struct ShowAddReview: View {
    var body: some View {
        HStack {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
            Text("New Review")
                .bold()
                .foregroundColor(.cyan)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .foregroundColor(Color.cyan)
        .padding(.leading)
        .accessibilityLabel("Add new review")
    }
}

struct ShowAddReview_Previews: PreviewProvider {
    static var previews: some View {
        ShowAddReview()
    }
}
