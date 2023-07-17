//
//  DiscoverUserView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI

struct DiscoverUserView: View {
    let user: User
    var body: some View {
        VStack {
            Image(user.profilImage)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(.infinity)

            Text(user.firstName)
                .font(.system(size: 11, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.label))
        }
        .frame(width: 60)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct DiscoverUserView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverUserView(user: .init(id: 0, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: []))
    }
}
