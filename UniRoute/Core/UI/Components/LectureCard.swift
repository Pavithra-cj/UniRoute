//
//  LectureScheduleCard.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct LectureCardView: View {
    let schedule: LectureSchedule
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(schedule.subject)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(schedule.instructor)
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack {
                Text(schedule.date.formatDate())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("•")
                    .foregroundColor(.secondary)
                
                Text("\(schedule.startTime.formatTime()) - \(schedule.endTime.formatTime())")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .cornerRadius(12)
    }
}
