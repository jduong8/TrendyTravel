//
//  RestaurantDetailsViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation

class RestaurantDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var details: Activity?

    init () {
        let urlString = "https://trendytravel.onrender.com/activities/4"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.details = try? JSONDecoder().decode(Activity.self, from: data)
            }
        }.resume()
    }
}
