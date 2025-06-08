//
//  ProfileView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct ProfileView: View {
    @State private var showingSignOffAlert = false
    @StateObject private var dashboardViewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Card at the top
                    ProfileCard(
                        email: dashboardViewModel.userEmail,
                        userId: dashboardViewModel.userID,
                        fullName: "Rudra Rakshath"
                    )
                    
                    // Menu Items Section
                    VStack(spacing: 0) {
                        ProfileMenuItem(
                            icon: "gearshape.fill",
                            title: "Settings",
                            subtitle: "App preferences and configurations",
                            destination: AnyView(SettingsView())
                        )
                        
                        Divider()
                            .padding(.leading, 60)
                        
                        ProfileMenuItem(
                            icon: "person.3.fill",
                            title: "Faculty Members",
                            subtitle: "View faculty contact information",
                            destination: AnyView(FacultyMembersView())
                        )
                        
                        Divider()
                            .padding(.leading, 60)
                        
                        ProfileMenuItem(
                            icon: "phone.circle.fill",
                            title: "Emergency Contacts",
                            subtitle: "Important emergency numbers",
                            destination: AnyView(EmergencyContactsView())
                        )
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                    
                    // Action Buttons Section
                    VStack(spacing: 16) {
                        // Change Password Button
                        NavigationLink(destination: ChangePasswordView()) {
                            HStack {
                                Image(systemName: "key.fill")
                                    .foregroundColor(.blue)
                                Text("Change Password")
                                    .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                    .foregroundColor(.blue)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ProfileView()
}
