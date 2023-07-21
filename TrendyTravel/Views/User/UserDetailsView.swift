//
//  UserDetailsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI
import MessageUI

struct UserDetailsView: View {
    @ObservedObject var vm : UserViewModel
    @State private var mailData = ComposeMailData(
        subject: "",
        recipients: [],
        message: "",
        attachments: [])
    @State var isShowingMailView = false
    @State private var isFollowed = false
    @State private var isLiked = false
    let user: User
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ProfilComponentView(user: user, followersNumber: vm.followers.count)
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
                        self.isShowingMailView.toggle()
                        mailData = ComposeMailData(
                            subject: "Contact between \(user.pseudo) and \(vm.user.pseudo) about TrendyTravel App",
                            recipients: [user.email],
                            message: "Hi",
                            attachments: [AttachmentData(
                                data: "Some text".data(using: .utf8)!,
                                mimeType: "text/plain",
                                fileName: "text.txt")
                            ])
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
                    .disabled(!MailView.canSendMail)
                    .foregroundColor(MailView.canSendMail ? Color.cyan.opacity(0.5) : .secondary)
                    .sheet(isPresented: $isShowingMailView) {
                        MailView(data: $mailData) { result in
                            print(result)
                        }
                    }
                }
                .font(.system(size: 12, weight: .semibold))
                if let posts = user.posts {
                    ForEach(posts, id: \.self) { post in
                        VStack(alignment: .leading) {
                            PostDescriptionView(user: user, post: post)
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
