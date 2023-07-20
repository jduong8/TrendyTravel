//
//  UserViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation
import NetworkManager

enum ErrorMessage: Error {
    case noUser
    case decodingError
    case badURL
    case badResponse
    
    var localizedDescription: String {
        switch self {
        case .noUser:
            return "No User"
        case .decodingError:
            return "Error while decoding error"
        case .badURL:
            return "Missing URL"
        case .badResponse:
            return "Bad response"
        }
    }
}


@MainActor class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var user: User = User(id: 1, firstName: "john", lastName: "doe", description: "hello I'm new", profilImage: "billy", pseudo: "jo.D", password: "kkk", email: "jo.d@gmail.com", posts: [Post(id: 0, title: "1st post", imageName: "eiffel_tower", hashtags: ["paradise", "lost"], userID: 0)], follower: [])
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
    
    func AddFollower(followerId: Int, followedId: Int) async throws -> Follower {
        print("1")
        //url
        guard let url = URL(string: "https://trendytravel.onrender.com/followers")
        else {
            print("2")
            throw ErrorMessage.badURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let body: [String: Int] = ["followerId": followerId, "followedId": followedId]
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("3")
        do{
            print("4")
            let follow = try decoder.decode(Follower.self, from: data)
            print("success created: \(follow)")
            return follow
        } catch {
            print("5 \(URLError(.badServerResponse))")
            throw URLError(.badServerResponse)
        }
    }
    func deleteFollower(id: Int) async throws -> Follower {
        print("1")
        guard let url = URL(string: "https://trendytravel.onrender.com/followers/46")
        else {
            print("2")
            throw ErrorMessage.badURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        print("3")
        let decoder = JSONDecoder()
        
        print("4")
        do{
            print("4")
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let follow = try decoder.decode(Follower.self, from: data)
            print("success deleted: \(follow)")
            return follow
        } catch {
            print("5 \(URLError(.badServerResponse))")
            throw URLError(.badServerResponse)
        }
    }
    func AddLike(userId: Int, postId: Int) async throws -> Like {
        guard let url = URL(string: "https://trendytravel.onrender.com/likes")
        else {
            throw ErrorMessage.badURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let body: [String: Int] = ["userId": userId, "postId": postId]
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do{
            let like = try decoder.decode(Like.self, from: data)
            print("success created: \(like)")
            return like
        } catch {
            throw URLError(.badServerResponse)
        }
    }
    func deleteLike(id: Int) async throws {
        guard let url = URL(string: "https://trendytravel.onrender.com/likes/\(id)")
        else {
            throw ErrorMessage.badURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let like = try decoder.decode(Like.self, from: data)
        
        print("success deleted: \(like)")
        return
    }
}
