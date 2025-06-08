//
//  MapView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var searchText: String = ""
    @StateObject private var mapViewModel = MapViewModel()
    @StateObject private var dashboardViewModel = DashboardViewModel()
    @State private var selectedPlace: Place?
    @State private var showingPlaceDetail = false
    @State private var showingDirections = false
    @State private var currentRoute: [CLLocationCoordinate2D] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Where do you want to go?", text: $searchText)
                            .font(.system(size: 16, weight: .medium))
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Button(action: {
                            // Voice search action
                        }) {
                            Image(systemName: "mic.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                
                // Map with Custom Overlays
                ZStack {
                    CustomMapView(
                        region: $mapViewModel.region,
                        places: dashboardViewModel.places,
                        selectedPlace: $selectedPlace,
                        showDirections: $showingDirections,
                        routeCoordinates: $currentRoute,
                        onPlaceSelected: { place in
                            selectedPlace = place
                            showingPlaceDetail = true
                        }
                    )
                    .edgesIgnoringSafeArea(.bottom)
                    
                    // Direction Controls Overlay
                    if showingDirections {
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        showingDirections = false
                                        currentRoute = []
                                        selectedPlace = nil
                                        // Reset map region
                                        mapViewModel.region = MKCoordinateRegion(
                                            center: CLLocationCoordinate2D(latitude: 6.906, longitude: 79.870),
                                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        )
                                    }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                                }
                                .padding(.trailing, 16)
                                .padding(.top, 8)
                            }
                            Spacer()
                        }
                    }
                    
                    // User Location Button
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    mapViewModel.region = MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(latitude: 6.906, longitude: 79.870),
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                    )
                                }
                            }) {
                                Image(systemName: "location.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .padding(12)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            }
                            .padding(.trailing, 16)
                            .padding(.bottom, 160)
                        }
                    }
                }
                
                // Places List at Bottom
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.black)
                        Text("Places")
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(filteredPlaces, id: \.id) { place in
                                PlaceCardView(place: place)
                                    .environmentObject(mapViewModel)
                                    .frame(width: 180)
                                    .onTapGesture {
                                        handlePlaceSelection(place)
                                    }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: -4)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingPlaceDetail) {
                if let place = selectedPlace {
                    PlaceDetailPopup(place: place)
                        .environmentObject(mapViewModel)
                }
            }
        }
        .onAppear {
            mapViewModel.places = dashboardViewModel.places
        }
    }
    
    private var filteredPlaces: [Place] {
        if searchText.isEmpty {
            return dashboardViewModel.places
        } else {
            return dashboardViewModel.places.filter { place in
                place.name.localizedCaseInsensitiveContains(searchText) ||
                place.floor.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private func handlePlaceSelection(_ place: Place) {
        selectedPlace = place
        
        // Navigate to place on map
        mapViewModel.navigateToPlace(place)
        
        // Show directions
        withAnimation {
            showingDirections = true
            currentRoute = generateHardcodedRoute(to: place)
        }
    }
    
    private func generateHardcodedRoute(to place: Place) -> [CLLocationCoordinate2D] {
        let userLocation = CLLocationCoordinate2D(latitude: 6.906, longitude: 79.870)
        
        switch place.name {
        case "Harrison Hall":
            return [
                userLocation,
                CLLocationCoordinate2D(latitude: 6.9065, longitude: 79.8705),
                CLLocationCoordinate2D(latitude: 6.9068, longitude: 79.8715),
                CLLocationCoordinate2D(latitude: 6.907, longitude: 79.873)
            ]
        case "CF - Canteen":
            return [
                userLocation,
                CLLocationCoordinate2D(latitude: 6.9055, longitude: 79.8695),
                CLLocationCoordinate2D(latitude: 6.9052, longitude: 79.8685),
                CLLocationCoordinate2D(latitude: 6.905, longitude: 79.868)
            ]
        default:
            return [userLocation]
        }
    }
}

struct CustomMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var places: [Place]
    @Binding var selectedPlace: Place?
    @Binding var showDirections: Bool
    @Binding var routeCoordinates: [CLLocationCoordinate2D]
    var onPlaceSelected: (Place) -> Void
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        
        // Add place annotations
        addPlaceAnnotations(to: mapView)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if mapView.region.center.latitude != region.center.latitude ||
            mapView.region.center.longitude != region.center.longitude {
            mapView.setRegion(region, animated: true)
        }
        
        // Update route overlay
        if showDirections && !routeCoordinates.isEmpty {
            // Remove existing overlays
            mapView.removeOverlays(mapView.overlays)
            
            // Add new route overlay
            let polyline = MKPolyline(coordinates: routeCoordinates, count: routeCoordinates.count)
            mapView.addOverlay(polyline)
        } else {
            // Remove all overlays if not showing directions
            mapView.removeOverlays(mapView.overlays)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func addPlaceAnnotations(to mapView: MKMapView) {
        let placeCoordinates: [String: CLLocationCoordinate2D] = [
            "Harrison Hall": CLLocationCoordinate2D(latitude: 6.907, longitude: 79.873),
            "CF - Canteen": CLLocationCoordinate2D(latitude: 6.905, longitude: 79.868)
        ]
        
        for place in places {
            if let coordinate = placeCoordinates[place.name] {
                let annotation = PlaceAnnotation(place: place, coordinate: coordinate)
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CustomMapView
        
        init(_ parent: CustomMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            guard let placeAnnotation = annotation as? PlaceAnnotation else {
                return nil
            }
            
            let identifier = "PlaceAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            
            // Customize marker based on place type
            if placeAnnotation.place.name.contains("Canteen") {
                annotationView?.markerTintColor = .systemOrange
                annotationView?.glyphImage = UIImage(systemName: "fork.knife")
            } else {
                annotationView?.markerTintColor = .systemBlue
                annotationView?.glyphImage = UIImage(systemName: "building.2")
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placeAnnotation = view.annotation as? PlaceAnnotation else { return }
            parent.onPlaceSelected(placeAnnotation.place)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 4.0
                renderer.lineDashPattern = [2, 5]
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            parent.region = mapView.region
        }
    }
}

class PlaceAnnotation: NSObject, MKAnnotation {
    let place: Place
    let coordinate: CLLocationCoordinate2D
    
    var title: String? {
        return place.name
    }
    
    var subtitle: String? {
        return place.floor
    }
    
    init(place: Place, coordinate: CLLocationCoordinate2D) {
        self.place = place
        self.coordinate = coordinate
        super.init()
    }
}

#Preview {
    MapView()
}
