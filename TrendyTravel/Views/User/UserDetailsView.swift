//
//  UserDetailsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct UserDetailsView: View {
    @ObservedObject var vm : UserViewModel
    @State private var isFollowed = false
    @State private var isLiked = false
    let user: User
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
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
                        Text("\(vm.followers.count)")
                            .onAppear {
                                Task {
                                    vm.followers = try await vm.getFolowerUser(id: user.id)
                                }
                            }
                            .font(.system(size: 13, weight: .semibold))
                        Text("Following")
                            .font(.system(size: 9, weight: .regular))
                    }
                }
                HStack(spacing: 12) {
                    Button {
                        isFollowed.toggle()
                        if isFollowed == true {
                            Task {
                                try await vm.AddFollower(followerId: vm.user.id, followedId: user.id)
                            }
                        } else {
                            Task {
                                try await vm.deleteFollower(id: vm.follower.id)
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Follow")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .background(isFollowed ? Color.cyan : Color.secondary)
                        .cornerRadius(50)
                    }
                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Contact")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .background(Color(white: 0.9))
                        .cornerRadius(50)
                    }
                }
                .font(.system(size: 12, weight: .semibold))
                if let posts = user.posts {
                    ForEach(user.posts!, id: \.self) { post in
                        VStack(alignment: .leading) {
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
                            HStack {
                                Button {
                                    isLiked.toggle()
                                    if isLiked == true {
                                        Task {
                                            try await vm.AddLike(userId: vm.user.id, postId: post.id)
                                        }
                                    } else {
                                        Task {
                                            try await vm.deleteLike(id: vm.user.id)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "hand.thumbsup.fill")
                                        .foregroundColor(isLiked ? .cyan : .secondary)
                                        .font(.system(size: 12))
                                }
                                Text("\(post.likes?.count ?? 0)")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 6)
                        }
                        .background(Color(white: 1))
                        .cornerRadius(12)
                        .shadow(color: .init(white: 0.8), radius: 5, x: 0, y: 4)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("\(user.pseudo)",  displayMode: .inline)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailsView(vm: UserViewModel(), user: User(id: 0, firstName: "john", lastName: "doe", description: "hello I'm new", profilImage: "billy", pseudo: "jo.D", password: "kkk", email: "jo.d@gmail.com", posts: [], follower: []))
        }
    }
}
