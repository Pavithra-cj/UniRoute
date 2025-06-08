//
//  SettingsView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct SettingsView: View {
    @State private var pushNotificationsEnabled = true
    @State private var emailNotificationsEnabled = true
    @State private var smsNotificationsEnabled = false
    @State private var selectedTheme = "System"
    @State private var selectedLanguage = "English"
    @State private var biometricAuthEnabled = false
    @State private var autoLockEnabled = true
    @State private var showDataUsage = false
    @State private var allowAnalytics = true
    @State private var showingThemePicker = false
    @State private var showingLanguagePicker = false
    @State private var showingLogoutAlert = false
    @State private var showingDeleteAccountAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    let themes = ["Light", "Dark", "System"]
    let languages = ["English", "Sinhala", "Tamil"]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Settings")
                        .font(.poppins(fontStyle: .title, fontWeight: .semibold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.poppins(fontStyle: .body, fontWeight: .medium))
                    .foregroundColor(.blue)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            
            ScrollView {
                VStack(spacing: 12) {
                    SettingsSection(title: "Notifications") {
                        SettingsRow {
                            HStack {
                                HStack(spacing: 12) {
                                    Image(systemName: "bell.fill")
                                        .foregroundColor(.blue)
                                        .font(.title3)
                                    
                                    Text("Push Notifications")
                                        .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $pushNotificationsEnabled)
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                            }
                        }
                        
                        SettingsRow {
                            HStack {
                                HStack(spacing: 12) {
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(.green)
                                        .font(.title3)
                                    
                                    Text("Email Notifications")
                                        .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $emailNotificationsEnabled)
                                    .toggleStyle(SwitchToggleStyle(tint: .green))
                            }
                        }
                        
                        SettingsRow {
                            HStack {
                                HStack(spacing: 12) {
                                    Image(systemName: "message.fill")
                                        .foregroundColor(.orange)
                                        .font(.title3)
                                    
                                    Text("SMS Notifications")
                                        .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $smsNotificationsEnabled)
                                    .toggleStyle(SwitchToggleStyle(tint: .orange))
                            }
                        }
                    }
                    
                    // Appearance Section
                    SettingsSection(title: "Appearance") {
                        SettingsRow {
                            HStack {
                                HStack(spacing: 12) {
                                    Image(systemName: "paintbrush.fill")
                                        .foregroundColor(.purple)
                                        .font(.title3)
                                    
                                    Text("Theme")
                                        .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    showingThemePicker = true
                                }) {
                                    HStack(spacing: 4) {
                                        Text(selectedTheme)
                                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                            .foregroundColor(.secondary)
                                        
                                        Image(systemName: "chevron.up.chevron.down")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        
                        SettingsRow {
                            HStack {
                                HStack(spacing: 12) {
                                    Image(systemName: "globe")
                                        .foregroundColor(.blue)
                                        .font(.title3)
                                    
                                    Text("Language")
                                        .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    showingLanguagePicker = true
                                }) {
                                    HStack(spacing: 4) {
                                        Text(selectedLanguage)
                                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                            .foregroundColor(.secondary)
                                        
                                        Image(systemName: "chevron.up.chevron.down")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    
                    // Security Section
                    SettingsSection(title: "Security") {
                        SettingsRow {
                            HStack {
                                HStack(spacing: 12) {
                                    Image(systemName: "faceid")
                                        .foregroundColor(.green)
                                        .font(.title3)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Biometric Authentication")
                                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                            .foregroundColor(.primary)
                                        
                                        Text("Use Face ID or Touch ID")
                                            .font(
                                                .poppins(
                                                    fontStyle: .caption,
                                                    fontWeight: .medium
                                                )
                                            )
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $biometricAuthEnabled)
                                    .toggleStyle(SwitchToggleStyle(tint: .green))
                            }
                        }
                        
                        SettingsRow {
                            HStack {
                                HStack(spacing: 12) {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.red)
                                        .font(.title3)
                                    
                                    Text("Auto Lock")
                                        .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $autoLockEnabled)
                                    .toggleStyle(SwitchToggleStyle(tint: .red))
                            }
                        }
                    }
                    
                    // Privacy Section
                    SettingsSection(title: "Privacy") {
                        SettingsRow {
                            HStack {
                                HStack(spacing: 12) {
                                    Image(systemName: "chart.bar.fill")
                                        .foregroundColor(.blue)
                                        .font(.title3)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Analytics")
                                            .font(
                                                .poppins(
                                                    fontStyle: .callout,
                                                    fontWeight: .medium
                                                )
                                            )
                                            .foregroundColor(.primary)
                                        
                                        Text("Help improve the app")
                                            .font(
                                                .poppins(
                                                    fontStyle: .caption,
                                                    fontWeight: .medium
                                                )
                                            )
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $allowAnalytics)
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                            }
                        }
                        
                        SettingsRow {
                            Button(action: {
                                showDataUsage = true
                            }) {
                                HStack {
                                    HStack(spacing: 12) {
                                        Image(systemName: "info.circle.fill")
                                            .foregroundColor(.orange)
                                            .font(.title3)
                                        
                                        Text("Data Usage")
                                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                            .foregroundColor(.primary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    
                    // Support Section
                    SettingsSection(title: "Support") {
                        SettingsRow {
                            Button(action: {
                                // Handle help & support action
                            }) {
                                HStack {
                                    HStack(spacing: 12) {
                                        Image(systemName: "questionmark.circle.fill")
                                            .foregroundColor(.blue)
                                            .font(.title3)
                                        
                                        Text("Help & Support")
                                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                            .foregroundColor(.primary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        
                        SettingsRow {
                            Button(action: {
                                // Handle privacy policy action
                            }) {
                                HStack {
                                    HStack(spacing: 12) {
                                        Image(systemName: "doc.text.fill")
                                            .foregroundColor(.gray)
                                            .font(.title3)
                                        
                                        Text("Privacy Policy")
                                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                            .foregroundColor(.primary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        
                        SettingsRow {
                            Button(action: {
                                // Handle terms of service action
                            }) {
                                HStack {
                                    HStack(spacing: 12) {
                                        Image(systemName: "doc.plaintext.fill")
                                            .foregroundColor(.gray)
                                            .font(.title3)
                                        
                                        Text("Terms of Service")
                                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                            .foregroundColor(.primary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    
                    // Account Section
                    SettingsSection(title: "Account") {
                        SettingsRow {
                            Button(action: {
                                showingLogoutAlert = true
                            }) {
                                HStack {
                                    HStack(spacing: 12) {
                                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                            .foregroundColor(.orange)
                                            .font(.title3)
                                        
                                        Text("Sign Out")
                                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                            .foregroundColor(.primary)
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        
                        SettingsRow {
                            Button(action: {
                                showingDeleteAccountAlert = true
                            }) {
                                HStack {
                                    HStack(spacing: 12) {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                            .font(.title3)
                                        
                                        Text("Delete Account")
                                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                            .foregroundColor(.red)
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    // App Version
                    VStack(spacing: 8) {
                        Text("Version 1.0.0")
                            .font(.poppins(fontStyle: .caption, fontWeight: .regular))
                            .foregroundColor(.secondary)
                        
                        Text("© 2025 Uni Route")
                            .font(.poppins(fontStyle: .caption, fontWeight: .regular))
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 32)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
//        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingThemePicker) {
            PickerSheet(
                title: "Select Theme",
                selectedItem: $selectedTheme,
                items: themes
            )
        }
        .sheet(isPresented: $showingLanguagePicker) {
            PickerSheet(
                title: "Select Language",
                selectedItem: $selectedLanguage,
                items: languages
            )
        }
        .alert("Sign Out", isPresented: $showingLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Sign Out", role: .destructive) {
                handleSignOut()
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
        .alert("Delete Account", isPresented: $showingDeleteAccountAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                handleDeleteAccount()
            }
        } message: {
            Text("This action cannot be undone. All your data will be permanently deleted.")
        }
    }
    
    private func handleSignOut() {
        print("Signing out user...")
        // Implement sign out logic
    }
    
    private func handleDeleteAccount() {
        print("Deleting user account...")
        // Implement account deletion logic
    }
}

// MARK: - Supporting Views

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.poppins(fontStyle: .caption, fontWeight: .semibold))
                .foregroundColor(.secondary)
                .padding(.horizontal, 20)
                .padding(.top, 8)
            
            VStack(spacing: 1) {
                content
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .padding(.horizontal, 16)
        }
    }
}

struct SettingsRow<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(.systemBackground))
    }
}

struct PickerSheet: View {
    let title: String
    @Binding var selectedItem: String
    let items: [String]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    HStack {
                        Text(item)
                            .font(.poppins(fontStyle: .body, fontWeight: .medium))
                        
                        Spacer()
                        
                        if item == selectedItem {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                                .font(.body.weight(.semibold))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedItem = item
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .presentationDetents([.medium])
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
