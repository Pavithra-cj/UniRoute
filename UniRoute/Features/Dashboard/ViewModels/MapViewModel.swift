//
//  MapViewModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.906, longitude: 79.870),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @Published var searchText: String = ""
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    @Published var showDirections: Bool = false
    
    private let placeCoordinates: [String: CLLocationCoordinate2D] = [
        "Harrison Hall": CLLocationCoordinate2D(latitude: 6.907, longitude: 79.873),
        "CF - Canteen": CLLocationCoordinate2D(latitude: 6.905, longitude: 79.868)
    ]
    
    private let userLocation = CLLocationCoordinate2D(latitude: 6.906, longitude: 79.870)
    
    func navigateToPlace(_ place: Place) {
        guard let coordinate = placeCoordinates[place.name] else {
            print("No coordinates found for \(place.name)")
            return
        }
        
        selectedPlace = place
        
        withAnimation {
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
        
        showDirections = true
    }
    
    func calculateRoute(to place: Place, completion: @escaping (MKRoute?) -> Void) {
        guard let destinationCoordinate = placeCoordinates[place.name] else {
            completion(nil)
            return
        }
        
        let sourcePlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first, error == nil else {
                print("Error calculating route: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            completion(route)
        }
    }
    
    func getEstimatedTravelTime(to place: Place, completion: @escaping (TimeInterval?) -> Void) {
        calculateRoute(to: place) { route in
            completion(route?.expectedTravelTime)
        }
    }
}
