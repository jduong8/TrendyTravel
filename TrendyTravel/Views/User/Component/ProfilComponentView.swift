//
//  ProfilComponentView.swift
//  TrendyTravel
//
//  Created by Cynthia on 20/07/2023.
//

import SwiftUI

struct ProfilComponentView: View {
    let user: User
    let followersNumber: Int
    var body: some View {
        AsyncImage(
            url: URL(string: user.profilImage),
            content: { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 80)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(
                        Circle()
                            .stroke(Color.cyan.opacity(0.6), lineWidth: 2)
                            .frame(width: 80, height: 80)
                    )
            },
            placeholder: {
                ProgressView()
            })
        Text("\(user.firstName) \(user.lastName)")
            .font(.system(size: 14, weight: .semibold))
        
        HStack {
            Text("@\(user.pseudo) •")
            Image(systemName: "hand.thumbsup.fill")
                .font(.system(size: 10, weight: .semibold))
            Text("\(user.posts?.count ?? 0)")
        }
        .font(.system(size: 12, weight: .regular))
        
        Text(user.description)
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(Color(.lightGray))
        HStack(spacing: 12) {
            VStack {
                Text("\(user.follower?.count ?? 0)")
                    .font(.system(size: 13, weight: .semibold))
                Text("Followers")
                    .font(.system(size: 9, weight: .regular))
            }
            Spacer()
                .frame(width: 0.5, height: 12)
                .background(Color(.lightGray))
            VStack {
                Text("\(followersNumber)")
                    .font(.system(size: 13, weight: .semibold))
                Text("Following")
                    .font(.system(size: 9, weight: .regular))
            }
        }
    }
}

struct ProfilComponentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProfilComponentView(user: .initial, followersNumber: 0)
        }
    }
}
