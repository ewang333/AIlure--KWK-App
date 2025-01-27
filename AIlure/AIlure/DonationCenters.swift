//
//  DonationCenters.swift
//  AIlure
//
//  Created by Eileen Wang on 1/18/25.
//

import SwiftUI
import CoreLocation
import MapKit

// Nearby donation centers feature
struct DonationCenters: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var donationCenterManager = DonationCenterManager()

    var body: some View {
        ZStack {
            // Background color
            Color("color1").ignoresSafeArea()

            VStack(spacing: 10) {
                Text("Got Old Clothes? Donate today!")
                    .font(.title2)
                    .foregroundColor(Color("color2"))
                    .padding(.top, -50) // Push text up

                Text("Click on the pins for directions to clothing donation centers near you!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                if locationManager.isLoading {
                    // Show a loading spinner while location is being fetched
                    VStack {
                        ProgressView("Fetching your location...")
                            .padding()
                            .foregroundColor(.white)
                        Spacer()
                    }
                } else if let location = locationManager.userLocation {
                    // Show the Map and List when location is available
                    MapView(userLocation: location, donationCenters: donationCenterManager.donationCenters)
                        .frame(height: 300)
                        .cornerRadius(10)
                        .padding()

                    List(donationCenterManager.donationCenters) { center in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(center.name)
                                .font(.headline)
                                .foregroundColor(Color("color1"))
                            Text(center.address)
                                .font(.subheadline)
                                .foregroundColor(Color("color4"))
                        }
                    }
                    .scrollContentBackground(.hidden) // Hides the default background of the list
                    .background(Color("color3"))
                    .cornerRadius(10)
                    
                    .onAppear {
                        donationCenterManager.fetchDonationCenters(
                            latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude
                        )
                    }
                } else {
                    // Show an error message if location could not be fetched
                    Text("Unable to fetch your location.")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    DonationCenters()
}
