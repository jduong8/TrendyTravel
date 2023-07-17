//
//  CategoryDetailsViewModel.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import Foundation

class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var activities: [ActivityModel] = []
    @Published var errorMessage = ""
    init() {
        let urlString = "https://trendytravel.onrender.com/activities"
        guard let url = URL(string: urlString)
        else {
            self.isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Bad status: \(statusCode)"
                    return
                }
                
                guard let data = data else { return }
                do {
                    self.activities = try JSONDecoder().decode([ActivityModel].self, from: data)
                } catch {
                    print("Failed to decode JSON: ", error)
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
        }.resume()
    }
}
