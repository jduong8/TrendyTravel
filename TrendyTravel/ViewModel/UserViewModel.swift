//
//  UserViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation
import NetworkManager

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var user: User = User(id: 0, firstName: "john", lastName: "doe", description: "hello I'm new", profilImage: "billy", pseudo: "jo.D", password: "kkk", email: "jo.d@gmail.com", posts: [Post(id: 0, title: "1st post", imageName: "eiffel_tower", hashtags: ["paradise", "lost"], userID: 0)])
    @Published var followers: [Follower] = []

    let baseURLUser = "https://trendytravel.onrender.com/users"
    let network = NetworkManager()

    func getUsers() async throws -> [User] {
        return try await network.fetch(from: baseURLUser)
    }

    func getUser(id: Int) async throws -> User {
        let userURL = "\(baseURLUser)/\(id)"
        return try await network.fetch(from: userURL)
    }
    
    func getFolowerUser(id: Int) async throws -> [Follower]{
        let userURL = "https://trendytravel.onrender.com/followers/\(id)"
        return try await network.fetch(from: userURL)
    }
    
}
