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
    @Published var user: User = .initial
    @Published var followers: [Follower] = []
    @Published var follower: Follower = .init(id: 1, followerID: 1, followedID: 1)
    @Published var like: Like = .init(id: 1, postID: 1, userID: 1)
    
    let baseURLUser = "https://trendytravel.onrender.com/users"
    let network = NetworkManager()
    
    func getUsers() async throws -> [User] {
        var fetchedUsers: [User] = try await network.fetch(from: baseURLUser)
        fetchedUsers.sort {
            guard let lhsUsers = $0.followers, let rhsUsers = $1.followers else {
                return ($0.followers?.count ?? 0) > ($1.followers?.count ?? 0)
            }
            return lhsUsers.count > rhsUsers.count
        }
        /*
         guard let lhsActivities = $0.activities, let rhsActivities = $1.activities else {
             // If either activity list is nil, consider its count as 0
             return ($0.activities?.count ?? 0) > ($1.activities?.count ?? 0)
         }

         // Compare the counts
         return lhsActivities.count > rhsActivities.count
         */
        self.users = fetchedUsers
        return self.users
    }
    
    func getUser(id: Int) async throws -> User {
        let userURL = "\(baseURLUser)/\(id)"
        return try await network.fetch(from: userURL)
    }
    
    func getFolowerUser(id: Int) async throws -> [Follower] {
        let userURL = "https://trendytravel.onrender.com/followers/\(id)"
        followers = try await network.fetch(from: userURL)
        return followers
    }
    
    func updateUser(userUpdate: User) async throws -> User {
        guard let url = URL(string: "\(baseURLUser)\(user.id)")
        else {
            throw ErrorMessage.badURL
        }
        var urlRequest = URLRequest(url: url)
        let parameters: [String : Any] = [
            "id" : user.id,
            "first_Name": userUpdate.firstName,
            "lastName": userUpdate.lastName,
            "description": userUpdate.description,
            "pseudo": userUpdate.pseudo,
            "password": userUpdate.password,
            "email": userUpdate.email
        ]
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            throw ErrorMessage.badResponse
        }
        
        let decoder = JSONDecoder()
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            user = try decoder.decode(User.self, from: data)
            print("success update: \(user)")
            return user
        } catch {
            throw URLError(.badServerResponse)
        }
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
            follower = try decoder.decode(Follower.self, from: data)
            print("success created: \(follower)")
            return follower
        } catch {
            print("5 \(URLError(.badServerResponse))")
            throw URLError(.badServerResponse)
        }
    }
    func deleteFollower(id: Int) async throws {
        print("1")
        Task {
            do {
                let followerDelete: () = try await network.delete(from: "https://trendytravel.onrender.com/followers/\(id)")
                print("sucess delete \(followerDelete)")
            } catch {
                print("Error fetching: \(error)")
            
            }
        }
        return
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
            like = try decoder.decode(Like.self, from: data)
            print("success created: \(like)")
            return like
        } catch {
            throw URLError(.badServerResponse)
        }
    }
    func deleteLike(id: Int) async throws {
        print("1")
        Task {
            do {
                let likeDelete: () = try await network.delete(from: "https://trendytravel.onrender.com/likes/\(id)")
                print("sucess delete \(likeDelete)")
            } catch {
                print("Error fetching: \(error)")
            
            }
        }
        return
    }
}
