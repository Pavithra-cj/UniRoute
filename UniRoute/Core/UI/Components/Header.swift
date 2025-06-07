//
//  Header.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct HeaderView: View {
    let studentName: String
    let hasUnreadNotifications: Bool
    
    private var salutation: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return "Good morning,"
        case 12..<17:
            return "Good afternoon,"
        case 17..<21:
            return "Good evening,"
        default:
            return "Good night,"
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(salutation)
                    .font(.poppins(fontStyle: .headline, fontWeight: .medium))
                    .foregroundColor(.gray)
                
                Text(studentName)
                    .font(.poppins(fontStyle: .title3, fontWeight: .bold))
            }
            
            Spacer()
            
            NavigationLink(destination: NotificationView()) {
                ZStack {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
                    
                    if hasUnreadNotifications {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 12, height: 12)
                            .offset(x: 10, y: -10)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 12, height: 12)
                                    .offset(x: 10, y: -10)
                            )
                    }
                }
            }
        }
        .padding(.horizontal, 4)
    }
}
