//
//  CategoryDetailLoadingView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct CategoryDetailLoadingView: View {
    var body: some View {
        VStack {
            ActivityIndicatorView()
            Text("Loading...")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
        }
        .padding()
        .background(Color.mint)
        .cornerRadius(8)
    }
}


struct CategoryDetailLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailLoadingView()
    }
}

extension CategoryDetailLoadingView {
    struct ActivityIndicatorView: UIViewRepresentable {
        typealias UIViewType = UIActivityIndicatorView
        
        func makeUIView(context: Context) -> UIActivityIndicatorView {
            let aiv = UIActivityIndicatorView(style: .large)
            aiv.startAnimating()
            aiv.color = .white
            return aiv
        }
        
        func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        }
    }
}
