//
//  MapView.swift
//  AIlure
//
//  Created by Eileen Wang on 1/20/25.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var userLocation: CLLocation
    var donationCenters: [DonationCenter]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations) // Clear existing annotations

        // Add donation center annotations
        for center in donationCenters {
            let annotation = MKPointAnnotation()
            annotation.title = center.name
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: center.latitude,
                longitude: center.longitude
            )
            mapView.addAnnotation(annotation)
        }

        // Center the map around the user's location
        let region = MKCoordinateRegion(
            center: userLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        mapView.setRegion(region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil // Use the default user location marker
            }

            let identifier = "DonationCenter"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                // Add a custom image
                annotationView?.glyphImage = UIImage(named: "donateLogo") // Replace with your asset name
                annotationView?.markerTintColor = UIColor(named: "color4")
                
                // Add a callout button
                let calloutButton = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = calloutButton
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }

        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let annotation = view.annotation else { return }

            // Open directions in Google Maps
            let coordinate = annotation.coordinate
            let url = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(coordinate.latitude),\(coordinate.longitude)")!

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

