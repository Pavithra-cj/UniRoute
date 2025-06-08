//
//  EditProfileView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct EditProfileView: View {
    @State private var firstName = "Rudra"
    @State private var lastName = "Rakshath"
    @State private var email = "rudra@student.nibm.lk"
    @State private var primaryBranch = "Nibm - Colombo"
    @State private var isAvailable = true
    @State private var pointsEarned = 120
    @State private var joinedAt = "27th of February 2025"
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSaveAlert = false
    @State private var isEditMode = false
    @State private var showingBranchPicker = false
    
    let branches = [
        "Nibm - Colombo",
        "Nibm - Kandy",
        "Nibm - Galle",
        "Nibm - Kurunegala"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with name and edit button
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("\(firstName), \(lastName.prefix(1)).")
                        .font(
                            .poppins(fontStyle: .title, fontWeight: .semibold)
                        )
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(isEditMode ? "Done" : "Edit") {
                        if isEditMode {
                            isEditMode = false
                        } else {
                            isEditMode = true
                        }
                    }
                    .font(.poppins(fontStyle: .body, fontWeight: .medium))
                    .foregroundColor(.blue)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            
            ScrollView {
                VStack(spacing: 0) {
                    ProfileSection {
                        HStack {
                            HStack(spacing: 12) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.blue)
                                    .font(.title3)
                                
                                Text("Points Earned")
                                    .font(
                                        .poppins(
                                            fontStyle: .callout,
                                            fontWeight: .medium
                                        )
                                    )
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                            
                            Text("\(pointsEarned.formatted())")
                                .font(
                                    .poppins(
                                        fontStyle: .callout,
                                        fontWeight: .medium
                                    )
                                )
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    ProfileSection {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Primary Branch")
                                    .font(
                                        .poppins(
                                            fontStyle: .callout,
                                            fontWeight: .medium
                                        )
                                    )
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                if isEditMode {
                                    Button(action: {
                                        showingBranchPicker = true
                                    }) {
                                        HStack(spacing: 4) {
                                            Text(primaryBranch)
                                                .font(
                                                    .poppins(
                                                        fontStyle: .callout,
                                                        fontWeight: .medium
                                                    )
                                                )
                                                .foregroundColor(.secondary)
                                            
                                            Image(systemName: "chevron.up.chevron.down")
                                                .font(.caption2)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                } else {
                                    HStack(spacing: 4) {
                                        Text(primaryBranch)
                                            .font(.poppins(fontStyle: .body, fontWeight: .medium))
                                            .foregroundColor(.secondary)
                                        
                                        Image(systemName: "chevron.up.chevron.down")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    
                    ProfileSection {
                        HStack {
                            Text("Availability")
                                .font(
                                    .poppins(
                                        fontStyle: .callout,
                                        fontWeight: .medium
                                    )
                                )
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Toggle("", isOn: $isAvailable)
                                .toggleStyle(SwitchToggleStyle(tint: .green))
                                .disabled(!isEditMode)
                        }
                    }
                    
                    ProfileSection {
                        HStack {
                            Text("First Name")
                                .font(
                                    .poppins(
                                        fontStyle: .callout,
                                        fontWeight: .medium
                                    )
                                )
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            TextField("First Name", text: $firstName)
                                .font(
                                    .poppins(
                                        fontStyle: .callout,
                                        fontWeight: .medium
                                    )
                                )
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.trailing)
                                .textFieldStyle(PlainTextFieldStyle())
                                .disabled(!isEditMode)
                        }
                    }
                    
                    ProfileSection {
                        HStack {
                            Text("Last Name")
                                .font(
                                    .poppins(
                                        fontStyle: .callout,
                                        fontWeight: .medium
                                    )
                                )
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            TextField("Last Name", text: $lastName)
                                .font(
                                    .poppins(
                                        fontStyle: .callout,
                                        fontWeight: .medium
                                    )
                                )
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.trailing)
                                .textFieldStyle(PlainTextFieldStyle())
                                .disabled(!isEditMode)
                        }
                    }
                    
                    ProfileSection {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Email")
                                    .font(
                                        .poppins(
                                            fontStyle: .callout,
                                            fontWeight: .medium
                                        )
                                    )
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                TextField("Email", text: $email)
                                    .font(
                                        .poppins(
                                            fontStyle: .callout,
                                            fontWeight: .medium
                                        )
                                    )
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.trailing)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .disabled(!isEditMode)
                            }
                        }
                    }
                    
                    ProfileSection {
                        HStack {
                            Text("Joined At")
                                .font(
                                    .poppins(
                                        fontStyle: .callout,
                                        fontWeight: .medium
                                    )
                                )
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text(joinedAt)
                                .font(
                                    .poppins(
                                        fontStyle: .callout,
                                        fontWeight: .medium
                                    )
                                )
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if isEditMode {
                        VStack(spacing: 16) {
                            MyButton(
                                title: "Save Changes",
                                variant: .primary,
                                size: .md,
                                width: .full
                            ) {
                                saveProfile()
                            }
                            .padding(.horizontal)
                            .padding(.top, 24)
                            
                            MyButton(
                                title: "Cancel",
                                variant: .secondary,
                                size: .md,
                                width: .full
                            ) {
                                cancelEdit()
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer(minLength: 32)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        //        .navigationBarHidden(true)
        //        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingBranchPicker) {
            BranchPickerSheet(selectedBranch: $primaryBranch, branches: branches)
        }
        .alert("Profile Updated", isPresented: $showingSaveAlert) {
            Button("OK") {
                isEditMode = false
            }
        } message: {
            Text("Your profile has been updated successfully.")
        }
    }
    
    private func saveProfile() {
        print("Saving profile...")
        print("First Name: \(firstName)")
        print("Last Name: \(lastName)")
        print("Email: \(email)")
        print("Primary Branch: \(primaryBranch)")
        print("Availability: \(isAvailable)")
        
        showingSaveAlert = true
    }
    
    private func cancelEdit() {
        isEditMode = false
    }
}

struct ProfileSection<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
        }
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color.green : Color.gray.opacity(0.3))
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 26, height: 26)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct BranchPickerSheet: View {
    @Binding var selectedBranch: String
    let branches: [String]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(branches, id: \.self) { branch in
                    HStack {
                        Text(branch)
                            .font(.poppins(fontStyle: .body, fontWeight: .medium))
                        
                        Spacer()
                        
                        if branch == selectedBranch {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                                .font(.body.weight(.semibold))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedBranch = branch
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Select Branch")
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
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfileView()
        }
    }
}
