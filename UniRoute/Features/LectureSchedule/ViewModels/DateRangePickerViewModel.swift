//
//  DateRangePickerViewModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

class DateRangePickerViewModel: ObservableObject {
    @Published var startDate: Date
    @Published var endDate: Date
    
    var isValidRange: Bool {
        startDate <= endDate
    }
    
    init(initialRange: ClosedRange<Date>) {
        self.startDate = initialRange.lowerBound
        self.endDate = initialRange.upperBound
    }
    
    func getSelectedRange() -> ClosedRange<Date>? {
        guard isValidRange else { return nil }
        return startDate...endDate
    }
}
