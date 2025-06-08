//
//  FacultyMembersView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct FacultyMembersView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.3.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Faculty Members")
                .font(.poppins(fontStyle: .subheadline, fontWeight: .bold))
            
            Text("Access contact information and details for all faculty members in your department.")
                .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                FacultyMembersRow(
                    title: "Tharun Weerasinghe",
                    email: "tharun@example.com"
                )
                FacultyMembersRow(title: "Rathsra Seneviratne", email: "rathsara@example.com")
                FacultyMembersRow(
                    title: "Abhimanthra Shakyamukhi",
                    email: "manthra@example.com"
                )
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Faculty Members")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FacultyMembersRow: View {
    let title: String
    let email: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.poppins(fontStyle: .callout, fontWeight: .semibold))
                Text(email)
                    .font(.poppins(fontStyle: .caption, fontWeight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                if let url = URL(string: "tel://\(email.replacingOccurrences(of: "-", with: ""))") {
                    UIApplication.shared.open(url)
                }
            }) {
                Image(systemName: "mail.fill")
                    .foregroundColor(.green)
                    .font(.title3)
            }
        }
    }
}

#Preview {
    FacultyMembersView()
}
