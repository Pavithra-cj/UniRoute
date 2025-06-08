//
//  ProfileMenuItem.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct ProfileMenuItem: View {
    let icon: String
    let title: String
    let subtitle: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.poppins(fontStyle: .callout, fontWeight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(
                            .poppins(fontStyle: .caption, fontWeight: .medium)
                        )
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}
