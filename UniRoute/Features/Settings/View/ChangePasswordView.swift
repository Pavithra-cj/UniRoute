//
//  ChangePasswordView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct ChangePasswordView: View {
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                Image(systemName: "key.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Change Password")
                    .font(.poppins(fontStyle: .subheadline, fontWeight: .bold))
                
                Text("Enter your current password and choose a new secure password.")
                    .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 16) {
                SecureField("Current Password", text: $currentPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("New Password", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Confirm New Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            MyButton(
                title: "Update Password",
                variant: .primary,
                size: .md,
                width: .full
            ) {
                changePassword()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Change Password")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Password Change", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func changePassword() {
        guard !currentPassword.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
            alertMessage = "Please fill in all fields."
            showingAlert = true
            return
        }
        
        guard newPassword == confirmPassword else {
            alertMessage = "New passwords do not match."
            showingAlert = true
            return
        }
        
        guard newPassword.count >= 8 else {
            alertMessage = "New password must be at least 8 characters long."
            showingAlert = true
            return
        }
        
        alertMessage = "Password updated successfully!"
        showingAlert = true
        
        currentPassword = ""
        newPassword = ""
        confirmPassword = ""
    }
}

#Preview {
    ChangePasswordView()
}
