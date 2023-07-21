//
//  AuthenticationViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 19/07/2023.
//

import Foundation
import UIKit

class AuthenticationViewModel: ObservableObject {
    @Published var authenticationType: AuthenticationType = .login
    @Published var user: User = .initial
    @Published var imageURL: String = "https://thispersondoesnotexist.com/"

    let urlUsers: String = "https://trendytravel.onrender.com/users"

    func addUser(user: User) async throws -> User {
        do {
            let newUser = try await self.createUser(user: user)
            DispatchQueue.main.async {
                self.user = newUser
            }
        } catch {
            print(error)
        }
        return self.user
    }

    func disabledCreateButton() -> Bool {
        if (user.pseudo.isEmpty ||
             user.firstName.isEmpty ||
             user.lastName.isEmpty ||
             user.email.isEmpty ||
             user.password.isEmpty ||
             user.description.isEmpty) {
            return true
        } else {
            return false
        }
    }
    func opacityCreateButton() -> Double {
        if (user.pseudo.isEmpty ||
             user.firstName.isEmpty ||
             user.lastName.isEmpty ||
             user.email.isEmpty ||
             user.password.isEmpty ||
             user.description.isEmpty) {
            return 0.4
        } else {
            return 1
        }
    }
}

extension AuthenticationViewModel {
    func loadImage() async throws -> UIImage {
        guard let url = URL(string: self.imageURL) else {
            fatalError("Invalid URL.")
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to decode image"])
        }
        return image
    }

    func createUser(user: User) async throws -> User {
        guard let url = URL(string: urlUsers)
        else {
            fatalError("Missing url")
        }

        let body: [String: Any] = [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "description": user.description,
            "profilImage": "https://thispersondoesnotexist.com/",
            "pseudo": user.pseudo,
            "password": user.password,
            "email": user.email,
        ]
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()

        let decodedUser = try decoder.decode(User.self, from: data)

        return decodedUser
    }
}
