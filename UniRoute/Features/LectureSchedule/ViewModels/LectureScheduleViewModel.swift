//
//  LectureScheduleViewModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI
import Combine

class LectureScheduleViewModel: ObservableObject {
    
    @Published var lecSchedule: [LectureSchedule] = [
        LectureSchedule(
            subject: "WEB DEVELOPMENT",
            instructor: "Mr. Rukshan Karunanayake",
            date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 13))!,
            startTime: Calendar.current.date(from: DateComponents(hour: 8, minute: 30))!,
            endTime: Calendar.current.date(from: DateComponents(hour: 11, minute: 30))!
        ),
        LectureSchedule(
            subject: "WEB DEVELOPMENT",
            instructor: "Mr. Rukshan Karunanayake",
            date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 13))!,
            startTime: Calendar.current.date(from: DateComponents(hour: 12, minute: 30))!,
            endTime: Calendar.current.date(from: DateComponents(hour: 15, minute: 30))!
        ),
        LectureSchedule(
            subject: "IOT",
            instructor: "Mr. Kamal Perera",
            date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 15))!,
            startTime: Calendar.current.date(from: DateComponents(hour: 8, minute: 30))!,
            endTime: Calendar.current.date(from: DateComponents(hour: 10, minute: 30))!
        ),
        LectureSchedule(
            subject: "ECS",
            instructor: "Mr. Samira Yapa",
            date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 15))!,
            startTime: Calendar.current.date(from: DateComponents(hour: 12, minute: 30))!,
            endTime: Calendar.current.date(from: DateComponents(hour: 15, minute: 30))!
        ),
        LectureSchedule(
            subject: "WEB DEVELOPMENT",
            instructor: "Mr. Rukshan Karunanayake",
            date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 17))!,
            startTime: Calendar.current.date(from: DateComponents(hour: 8, minute: 30))!,
            endTime: Calendar.current.date(from: DateComponents(hour: 11, minute: 30))!
        )
    ]
    
    @Published var selectedDateRange: ClosedRange<Date> = {
        let start = Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 13))!
        let end = Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 23))!
        return start...end
    }()
    
    var filteredSchedules: [LectureSchedule] {
        lecSchedule.filter { schedule in
            selectedDateRange.contains(schedule.date)
        }.sorted { $0.date < $1.date }
    }
    
    var groupedSchedules: [(key: Date, value: [LectureSchedule])] {
        let grouped = Dictionary(grouping: filteredSchedules) { schedule in
            Calendar.current.startOfDay(for: schedule.date)
        }
        return grouped.sorted { $0.key < $1.key }
    }
    
    var dateRangeText: String {
        "\(selectedDateRange.lowerBound.formatDate()) - \(selectedDateRange.upperBound.formatDate())"
    }
    
    func updateDateRange(_ newRange: ClosedRange<Date>) {
        selectedDateRange = newRange
    }
}
