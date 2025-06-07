//
//  HistoryCard.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct HistoryCard: View {
    let item: HistoryItem
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: item.type.icon)
                .font(.system(size: 24))
                .foregroundColor(item.type.color)
                .frame(width: 40, height: 40)
                .background(item.type.color.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(item.description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                Text(dateFormatter.string(from: item.date))
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(item.points > 0 ? "+\(item.points)" : "\(item.points)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(item.points > 0 ? .green : .red)
                
                HStack(spacing: 2) {
                    Image(systemName: "medal.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.yellow)
                    
                    Text("pts")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
