//
//  DashboardModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import Foundation

struct Event {
    var title: String
    var location: String
    var startTime: String
    var remainingMinutes: Int
    var date: String
    var image: String = "lecture_hall"
    var batch: String
    var lecturer: String
    var lectureHall: String
    var floor: String
}

struct Place: Equatable {
    var name: String
    var floor: String
    var distance: Int
    var crowdLevel: String
    var startTime: String = ""
    var date: String = ""
    var image: String = "lecture_hall"
    
    // Implementing Equatable manually to ensure proper comparison
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.name == rhs.name &&
        lhs.floor == rhs.floor &&
        lhs.distance == rhs.distance &&
        lhs.crowdLevel == rhs.crowdLevel &&
        lhs.startTime == rhs.startTime &&
        lhs.date == rhs.date &&
        lhs.image == rhs.image
    }
}
