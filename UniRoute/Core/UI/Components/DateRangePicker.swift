//
//  DateRangePicker.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct DateRangePickerView: View {
    @StateObject private var viewModel: DateRangePickerViewModel
    @Environment(\.dismiss) private var dismiss
    
    let onRangeSelected: (ClosedRange<Date>) -> Void
    
    init(initialRange: ClosedRange<Date>, onRangeSelected: @escaping (ClosedRange<Date>) -> Void) {
        self._viewModel = StateObject(wrappedValue: DateRangePickerViewModel(initialRange: initialRange))
        self.onRangeSelected = onRangeSelected
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Select Date Range")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Start Date")
                            .font(.headline)
                        DatePicker("", selection: $viewModel.startDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("End Date")
                            .font(.headline)
                        DatePicker("", selection: $viewModel.endDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                    
                    if !viewModel.isValidRange {
                        Text("End date must be after start date")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .foregroundColor(.primary)
                    .cornerRadius(12)
                    
                    Button("Apply") {
                        if let range = viewModel.getSelectedRange() {
                            onRangeSelected(range)
                        }
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isValidRange ? Color.blue : Color(.systemGray4))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(!viewModel.isValidRange)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationBarHidden(true)
        }
    }
}
