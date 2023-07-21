//
//  PostDescriptionView.swift
//  TrendyTravel
//
//  Created by Cynthia on 20/07/2023.
//

import SwiftUI

struct PostDescriptionView: View {
    let user: User
    let post: Post
    var body: some View {
        AsyncImage(
            url: URL(string: post.imageName),
            content: { image in
                image.resizable()
                    .scaledToFill()
                    .clipped()
            },
            placeholder: {
                ProgressView()
            })
        HStack(alignment: .top) {
            AsyncImage(
                url: URL(string: user.profilImage),
                content: { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 34)
                        .clipShape(Circle())
                },
                placeholder: {
                    ProgressView()
                })
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.system(size: 14, weight: .semibold))
                HStack {
                    ForEach(post.hashtags, id: \.self) { hashtag in
                        Text("#\(hashtag)")
                            .foregroundColor(Color.purple)
                            .font(.system(size: 13, weight: .semibold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 2)
                            .background(Color.purple.opacity(0.2))
                            .cornerRadius(20)
                    }
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

struct PostDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            PostDescriptionView(user: .initial, post: .init(id: 1, title: "", imageName: "", hashtags: [], userID: 1))
        }
    }
}
