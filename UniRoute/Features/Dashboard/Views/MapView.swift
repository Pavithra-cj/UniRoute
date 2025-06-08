//
//  MapView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI
import MapKit

struct DirectionStep {
    let instruction: String
    let distance: String
    let icon: String
}

struct MapView: View {
    @State private var searchText: String = ""
    @StateObject private var mapViewModel = MapViewModel()
    @StateObject private var dashboardViewModel = DashboardViewModel()
    @State private var selectedPlace: Place?
    @State private var showingPlaceDetail = false
    @State private var showingDirections = false
    @State private var currentRoute: [CLLocationCoordinate2D] = []
    @State private var directionSteps: [DirectionStep] = []
    @State private var currentStepIndex = 0
    @State private var estimatedTime = ""
    @State private var totalDistance = ""
    
    private let currentLocation = CLLocationCoordinate2D(latitude: 6.9055, longitude: 79.8695)
    
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
                
                ZStack {
                    CustomMapView(
                        region: $mapViewModel.region,
                        places: dashboardViewModel.places,
                        selectedPlace: $selectedPlace,
                        showDirections: $showingDirections,
                        routeCoordinates: $currentRoute,
                        currentLocation: currentLocation,
                        onPlaceSelected: { place in
                            selectedPlace = place
                            showingPlaceDetail = true
                        }
                    )
                    .edgesIgnoringSafeArea(.bottom)
                    
                    if showingDirections && !directionSteps.isEmpty {
                        VStack {
                            NavigationInstructionCard(
                                currentStep: directionSteps[safe: currentStepIndex],
                                nextStep: directionSteps[safe: currentStepIndex + 1],
                                totalDistance: totalDistance,
                                estimatedTime: estimatedTime,
                                onClose: {
                                    withAnimation {
                                        resetNavigation()
                                    }
                                }
                            )
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                            
                            Spacer()
                            
                            NavigationControlsView(
                                currentStepIndex: currentStepIndex,
                                totalSteps: directionSteps.count,
                                onPrevious: {
                                    if currentStepIndex > 0 {
                                        currentStepIndex -= 1
                                    }
                                },
                                onNext: {
                                    if currentStepIndex < directionSteps.count - 1 {
                                        currentStepIndex += 1
                                    }
                                },
                                onStop: {
                                    withAnimation {
                                        resetNavigation()
                                    }
                                }
                            )
                            .padding(.horizontal, 16)
                            .padding(.bottom, 180)
                        }
                    }
                    
                    if !showingDirections {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        mapViewModel.region = MKCoordinateRegion(
                                            center: currentLocation,
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
                }
                
                if !showingDirections {
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
            mapViewModel.region = MKCoordinateRegion(
                center: currentLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
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
        
        let (route, directions, time, distance) = generateDetailedRoute(to: place)
        
        mapViewModel.navigateToPlace(place)
        
        withAnimation {
            showingDirections = true
            currentRoute = route
            directionSteps = directions
            currentStepIndex = 0
            estimatedTime = time
            totalDistance = distance
        }
    }
    
    private func resetNavigation() {
        showingDirections = false
        currentRoute = []
        directionSteps = []
        currentStepIndex = 0
        selectedPlace = nil
        estimatedTime = ""
        totalDistance = ""
        
        mapViewModel.region = MKCoordinateRegion(
            center: currentLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
    
    private func generateDetailedRoute(to place: Place) -> ([CLLocationCoordinate2D], [DirectionStep], String, String) {
        let userLocation = currentLocation
        
        switch place.name {
        case "Harrison Hall":
            let route = [
                userLocation,
                CLLocationCoordinate2D(latitude: 6.9058, longitude: 79.8702),
                CLLocationCoordinate2D(latitude: 6.9062, longitude: 79.8710),
                CLLocationCoordinate2D(latitude: 6.9065, longitude: 79.8718),
                CLLocationCoordinate2D(latitude: 6.9068, longitude: 79.8725),
                CLLocationCoordinate2D(latitude: 6.907, longitude: 79.873)
            ]
            
            let directions = [
                DirectionStep(instruction: "Head northeast from campus entrance", distance: "50m", icon: "arrow.up.right"),
                DirectionStep(instruction: "Turn right onto University Road", distance: "80m", icon: "arrow.turn.up.right"),
                DirectionStep(instruction: "Continue straight for 100 meters", distance: "100m", icon: "arrow.up"),
                DirectionStep(instruction: "Turn left towards academic buildings", distance: "70m", icon: "arrow.turn.up.left"),
                DirectionStep(instruction: "Continue straight to Harrison Hall", distance: "60m", icon: "arrow.up"),
                DirectionStep(instruction: "You have arrived at Harrison Hall", distance: "0m", icon: "flag.checkered")
            ]
            
            return (route, directions, "4 min", "360m")
            
        case "CF - Canteen":
            let route = [
                userLocation,
                CLLocationCoordinate2D(latitude: 6.9052, longitude: 79.8688),
                CLLocationCoordinate2D(latitude: 6.9050, longitude: 79.8682),
                CLLocationCoordinate2D(latitude: 6.9048, longitude: 79.8678),
                CLLocationCoordinate2D(latitude: 6.905, longitude: 79.868)
            ]
            
            let directions = [
                DirectionStep(instruction: "Head southwest from campus entrance", distance: "40m", icon: "arrow.down.left"),
                DirectionStep(instruction: "Turn left towards student facilities", distance: "60m", icon: "arrow.turn.down.left"),
                DirectionStep(instruction: "Continue straight to canteen building", distance: "50m", icon: "arrow.down"),
                DirectionStep(instruction: "Enter CF Canteen on your right", distance: "20m", icon: "arrow.turn.up.right"),
                DirectionStep(instruction: "You have arrived at CF Canteen", distance: "0m", icon: "flag.checkered")
            ]
            
            return (route, directions, "3 min", "170m")
            
        default:
            return ([userLocation], [DirectionStep(instruction: "Location not found", distance: "0m", icon: "exclamationmark.triangle")], "0 min", "0m")
        }
    }
}

struct NavigationInstructionCard: View {
    let currentStep: DirectionStep?
    let nextStep: DirectionStep?
    let totalDistance: String
    let estimatedTime: String
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(estimatedTime)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Text(totalDistance)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            if let step = currentStep {
                HStack(spacing: 12) {
                    Image(systemName: step.icon)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 30)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(step.instruction)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        if step.distance != "0m" {
                            Text("in \(step.distance)")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    
                    Spacer()
                }
            }
            
            if let nextStep = nextStep {
                HStack(spacing: 12) {
                    Image(systemName: "arrow.up.circle")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 30)
                    
                    Text("Then \(nextStep.instruction.lowercased())")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
    }
}

struct NavigationControlsView: View {
    let currentStepIndex: Int
    let totalSteps: Int
    let onPrevious: () -> Void
    let onNext: () -> Void
    let onStop: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: onPrevious) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(currentStepIndex > 0 ? .blue : .gray)
                    .padding(12)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            }
            .disabled(currentStepIndex <= 0)
            
            VStack(spacing: 4) {
                Text("\(currentStepIndex + 1) of \(totalSteps)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 4)
                            .cornerRadius(2)
                        
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: geometry.size.width * CGFloat(currentStepIndex + 1) / CGFloat(totalSteps), height: 4)
                            .cornerRadius(2)
                    }
                }
                .frame(height: 4)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: onNext) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(currentStepIndex < totalSteps - 1 ? .blue : .gray)
                    .padding(12)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            }
            .disabled(currentStepIndex >= totalSteps - 1)
            
            Button(action: onStop) {
                Image(systemName: "stop.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.red)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.9))
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct CustomMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var places: [Place]
    @Binding var selectedPlace: Place?
    @Binding var showDirections: Bool
    @Binding var routeCoordinates: [CLLocationCoordinate2D]
    let currentLocation: CLLocationCoordinate2D
    var onPlaceSelected: (Place) -> Void
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        mapView.showsUserLocation = false
        mapView.userTrackingMode = .none
        
        let userAnnotation = UserLocationAnnotation(coordinate: currentLocation)
        mapView.addAnnotation(userAnnotation)
        
        addPlaceAnnotations(to: mapView)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if mapView.region.center.latitude != region.center.latitude ||
            mapView.region.center.longitude != region.center.longitude {
            mapView.setRegion(region, animated: true)
        }
        
        if showDirections && !routeCoordinates.isEmpty {
            mapView.removeOverlays(mapView.overlays)
            
            let polyline = MKPolyline(coordinates: routeCoordinates, count: routeCoordinates.count)
            mapView.addOverlay(polyline)
            
            mapView.setVisibleMapRect(polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 50, bottom: 300, right: 50), animated: true)
        } else {
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
            if let userAnnotation = annotation as? UserLocationAnnotation {
                let identifier = "UserLocation"
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                
                if annotationView == nil {
                    annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                }
                
                let pinView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                pinView.backgroundColor = .systemBlue
                pinView.layer.cornerRadius = 10
                pinView.layer.borderWidth = 3
                pinView.layer.borderColor = UIColor.white.cgColor
                
                UIGraphicsBeginImageContextWithOptions(pinView.bounds.size, false, 0)
                pinView.layer.render(in: UIGraphicsGetCurrentContext()!)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                annotationView?.image = image
                annotationView?.centerOffset = CGPoint(x: 0, y: -10)
                
                return annotationView
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
                renderer.lineWidth = 5.0
                renderer.lineDashPattern = nil
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            parent.region = mapView.region
        }
    }
}

class UserLocationAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    var title: String? {
        return "Your Location"
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
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

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    MapView()
}
