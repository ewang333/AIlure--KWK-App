//
//  LocationManager.swift
//  AIlure
//
//  Created by Eileen Wang on 1/18/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation? // The user's current location
    @Published var isLoading = true // State to indicate if the location is loading

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestLocationPermissions()
    }

    func requestLocationPermissions() {
        print("Requesting location permissions...")
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func requestLocation() {
        print("Requesting location update...")
        isLoading = true
        locationManager.requestLocation()
    }

    // Delegate method for location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("No location data available.")
            return
        }
        DispatchQueue.main.async {
            self.userLocation = location
            self.isLoading = false // Stop loading when location is updated
            print("User location updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
        locationManager.stopUpdatingLocation() // Stop updates to save battery
    }

    // Delegate method for errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error fetching location: \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}
