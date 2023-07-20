//
//  UserViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation
import NetworkManager

@MainActor class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var user: User = .initial
    @Published var followers: [Follower] = []

    let baseURLUser = "https://trendytravel.onrender.com/users"
    let network = NetworkManager()

    func getUsers() async throws -> [User] {
        var fetchedUsers: [User] = try await network.fetch(from: baseURLUser)
        fetchedUsers.sort {
            guard let lhsUsers = $0.follower, let rhsUsers = $1.follower else {
                return ($0.follower?.count ?? 0) > ($1.follower?.count ?? 0)
            }
            return lhsUsers.count > rhsUsers.count
        }
        self.users = fetchedUsers
        return self.users
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
