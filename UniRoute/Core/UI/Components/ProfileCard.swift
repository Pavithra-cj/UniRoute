//
//  ProfileCard.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct ProfileCard: View {
    var email: String
    var userId: String
    var fullName: String
    var profileImage: String = "person.circle.fill"
    
    var body: some View {
        NavigationLink(destination: EditProfileView()) {
            ProfileCardContent(
                email: email,
                userId: userId,
                fullName: fullName,
                profileImage: profileImage
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ProfileCardContent: View {
    var email: String
    var userId: String
    var fullName: String
    var profileImage: String
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Full Name")
                        .font(.poppins(fontStyle: .caption, fontWeight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text(fullName)
                        .font(.poppins(fontStyle: .title3, fontWeight: .semibold))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Email")
                        .font(.poppins(fontStyle: .caption, fontWeight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text(email)
                        .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("User ID")
                        .font(.poppins(fontStyle: .caption, fontWeight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text(userId)
                        .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            
            Spacer()
            
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: profileImage)
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Circle()
                                .fill(Color.white)
                                .frame(width: 24, height: 24)
                                .overlay(
                                    Image(systemName: "pencil")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.blue)
                                )
                                .offset(x: 8, y: 8)
                        }
                    }
                    .frame(width: 80, height: 80)
                }
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.3, green: 0.6, blue: 1.0),
                    Color(red: 0.2, green: 0.5, blue: 0.9)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// Preview
struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            NavigationView {
                ProfileCard(
                    email: "jane.smith@example.com",
                    userId: "USR789012",
                    fullName: "Jane Smith"
                )
            }
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
