//
//  FacilityViewModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

class FacilityViewModel: ObservableObject {
    @Published var facilities: [Place] = []
    @Published var sliderItems: [SliderItem] = []
    @Published var selectedPlace: Place?
    @Published var showPlaceDetail = false
    @Published var currentSliderIndex = 0
    
    private var timer: Timer?
    
    init() {
        loadSampleData()
        startSliderTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    private func loadSampleData() {
        sliderItems = [
            SliderItem(image: "campus_slide1", title: "Welcome to Campus", subtitle: "Navigate with ease"),
            SliderItem(image: "campus_slide2", title: "Find Your Way", subtitle: "Discover facilities"),
            SliderItem(image: "campus_slide3", title: "", subtitle: "")
        ]
        
        facilities = [
            Place(name: "Harrison Hall", floor: "Computing Faculty", distance: 10, crowdLevel: "Not Crowded", startTime: "13:30", date: "01/02/2025", image: "lecHall_image"),
            Place(name: "Library", floor: "Ground Floor", distance: 50, crowdLevel: "Moderate", image: "library_image"),
            Place(name: "Cafeteria", floor: "First Floor", distance: 75, crowdLevel: "Crowded", image: "cafeteria_image"),
            Place(name: "Student Center", floor: "Second Floor", distance: 120, crowdLevel: "Not Crowded", image: "student_center_image"),
            Place(name: "Lab Complex", floor: "Computing Faculty", distance: 30, crowdLevel: "Very Crowded", image: "lab_image")
        ]
    }
    
    private func startSliderTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                self.currentSliderIndex = (self.currentSliderIndex + 1) % self.sliderItems.count
            }
        }
    }
    
    func selectPlace(_ place: Place) {
        selectedPlace = place
        showPlaceDetail = true
    }
    
    func getEstimatedTravelTime(to place: Place, completion: @escaping (TimeInterval?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let estimatedTime = TimeInterval(place.distance * 5)
            completion(estimatedTime)
        }
    }
    
    func navigateToPlace(_ place: Place) {
        print("Navigating to \(place.name)")
    }
}
