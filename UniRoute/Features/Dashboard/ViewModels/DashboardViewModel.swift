//
//  DashboardViewModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI
import Combine

class DashboardViewModel: ObservableObject {
    @Published var userName: String = "Rakshath"
    @Published var userID: String = "YR4COBBSC#####"
    @Published var userEmail: String = "rudra@student.nibm.lk"
    @Published var userPoints: Int = 50
    
    @Published var nextEvent: Event = Event(
        title: "iOS Application Development",
        location: "3rd Floor iOS Lab",
        startTime: "10:30 AM",
        remainingMinutes: 15,
        date: "Today",
        image: "lecHall_image",
        batch: "BSc23.2",
        lecturer: "N.M. Fuzail",
        lectureHall: "iOS Lab",
        floor: "3rd Floor"
    )
    
    @Published var searchedPlaces: [Place] = [
        Place(
            name: "CF - Canteen",
            floor: "5th block, computing faculty",
            distance: 400,
            crowdLevel: "Very Crowded",
            image: "canteen_image"
        ),
        Place(
            name: "Cafetaria",
            floor: "5th block, computing faculty",
            distance: 400,
            crowdLevel: "Not Crowded",
            image: "canteen_image"
        ),
        Place(
            name: "iOS Lab",
            floor: "5th block, computing faculty",
            distance: 400,
            crowdLevel: "Not Crowded",
            image: "canteen_image"
        )
    ]
    
    @Published var places: [Place] = [
        Place(
            name: "Harrison Hall",
            floor: "Computing Faculty",
            distance: 10,
            crowdLevel: "Not Crowded",
            startTime: "13:30",
            date: "01/02/2025",
            image: "lecHall_image"
        ),
        Place(
            name: "CF - Canteen",
            floor: "5th block, computing faculty",
            distance: 400,
            crowdLevel: "Very Crowded",
            image: "canteen_image"
        )
    ]
    
    @Published var recentLocations: [Place] = [
        Place(
            name: "Harrison Hall",
            floor: "Computing Faculty",
            distance: 10,
            crowdLevel: "",
            startTime: "13:30",
            date: "01/02/2025",
            image: "lecHall_image"
        ),
        Place(
            name: "Harrison Hall",
            floor: "Computing Faculty",
            distance: 10,
            crowdLevel: "",
            startTime: "13:30",
            date: "01/02/2025",
            image: "lecHall_image"
        ),
        Place(
            name: "Harrison Hall",
            floor: "Computing Faculty",
            distance: 10,
            crowdLevel: "",
            startTime: "13:30",
            date: "01/02/2025",
            image: "lecHall_image"
        ),
        Place(
            name: "Harrison Hall",
            floor: "Computing Faculty",
            distance: 10,
            crowdLevel: "",
            startTime: "13:30",
            date: "01/02/2025",
            image: "lecHall_image"
        ),
        Place(
            name: "Harrison Hall",
            floor: "Computing Faculty",
            distance: 10,
            crowdLevel: "",
            startTime: "13:30",
            date: "01/02/2025",
            image: "lecHall_image"
        ),
        Place(
            name: "Canteen",
            floor: "Ground Floor",
            distance: 400,
            crowdLevel: "Very Crowded",
            startTime: "13:30",
            date: "01/02/2025",
            image: "canteen_image"
        )
    ]
}
