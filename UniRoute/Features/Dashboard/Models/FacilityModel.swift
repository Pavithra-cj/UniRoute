//
//  FacilityModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI
import Combine

struct Facility: Identifiable, Codable {
    let id = UUID()
    let name: String
    let floor: String
    let distance: Int
    let crowdLevel: String
    let startTime: String
    let date: String
    let image: String
    let category: String?
    let description: String?
    
    init(name: String, floor: String, distance: Int, crowdLevel: String, startTime: String = "", date: String = "", image: String, category: String? = nil, description: String? = nil) {
        self.name = name
        self.floor = floor
        self.distance = distance
        self.crowdLevel = crowdLevel
        self.startTime = startTime
        self.date = date
        self.image = image
        self.category = category
        self.description = description
    }
}

struct SliderItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subtitle: String
}
