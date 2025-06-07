//
//  LectureScheduleView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct LectureScheduleView: View {
    @StateObject private var viewModel = LectureScheduleViewModel()
    @State private var showDatePicker = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text("Schedule")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        showDatePicker.toggle()
                    }) {
                        HStack {
                            Text(viewModel.dateRangeText)
                                .font(.title3)
                                .foregroundColor(.primary)
                            
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.groupedSchedules, id: \.key) { dateGroup in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(dateGroup.key.formatDate())
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 20)
                                
                                ForEach(dateGroup.value, id: \.id) { schedule in
                                    LectureCardView(schedule: schedule)
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .background(Color(.systemBackground))
        }
        .sheet(isPresented: $showDatePicker) {
            DateRangePickerView(
                initialRange: viewModel.selectedDateRange,
                onRangeSelected: { newRange in
                    viewModel.updateDateRange(newRange)
                }
            )
        }
    }
}

#Preview {
    LectureScheduleView()
}
