//
//  FacilityCard.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct FacilityCard: View {
    let facility: Place
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                Image(facility.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(facility.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.blue)
                            .font(.caption)
                        
                        Text(facility.floor)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: "ruler")
                            .foregroundColor(.blue)
                            .font(.caption)
                        
                        Text("\(facility.distance)m away")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if !facility.crowdLevel.isEmpty {
                        HStack {
                            Circle()
                                .fill(crowdLevelColor(for: facility.crowdLevel))
                                .frame(width: 8, height: 8)
                            
                            Text(facility.crowdLevel)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(crowdLevelColor(for: facility.crowdLevel))
                        }
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func crowdLevelColor(for level: String) -> Color {
        switch level {
        case "Very Crowded": return .red
        case "Crowded": return .orange
        case "Moderate": return .yellow
        case "Not Crowded": return .green
        default: return .blue
        }
    }
}
