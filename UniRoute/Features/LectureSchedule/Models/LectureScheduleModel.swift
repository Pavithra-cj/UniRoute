//
//  LectureScheduleModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI
import Foundation

struct LectureSchedule: Identifiable {
    let id = UUID()
    let subject: String
    let instructor: String
    let date: Date
    let startTime: Date
    let endTime: Date
}
