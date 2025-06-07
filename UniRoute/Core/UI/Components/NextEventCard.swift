//
//  NextEventCard.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct NextEventCard: View {
    var event: Event
    
    var body: some View {
        HStack {
            Image(event.image)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.poppins(fontStyle: .caption, fontWeight: .semibold))
                
                Text(event.location)
                    .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                
                Text("Lecture Start in \(event.remainingMinutes) mins")
                    .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
