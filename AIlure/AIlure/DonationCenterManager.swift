//
//  DonationCenterManager.swift
//  AIlure
//
//  Created by Eileen Wang on 1/18/25.
//

import Foundation
import CoreLocation

struct DonationCenter: Codable, Identifiable {
    let id = UUID() // Unique identifier for SwiftUI lists
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
}

class DonationCenterManager: ObservableObject {
    @Published var donationCenters: [DonationCenter] = []
    private let apiKey = "AIzaSyDzWiWDwnGnl3lYfGFXiFVKQ6ZXIAdq_UI" // API key from Google Cloud Console
    
    // Find donation centers near user
    func fetchDonationCenters(latitude: Double, longitude: Double) {
        print("Fetching donation centers for location: \(latitude), \(longitude)")
        
        let urlString = """
        https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=10000&keyword=clothing+donation+center&key=\(apiKey)
        """
        print("Request URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching donation centers: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    print("Unexpected status code: \(httpResponse.statusCode)")
                    return
                }
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(GooglePlacesResponse.self, from: data)
                DispatchQueue.main.async {
                    self.donationCenters = result.results.map { place in
                        DonationCenter(
                            name: place.name,
                            address: place.vicinity,
                            latitude: place.geometry.location.lat,
                            longitude: place.geometry.location.lng
                        )
                    }
                    print("Donation centers fetched: \(result.results.count)")
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

// Structs to decode the Google Places API response
struct GooglePlacesResponse: Codable {
    let results: [Place]
}

struct Place: Codable {
    let name: String
    let vicinity: String
    let geometry: Geometry
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}
