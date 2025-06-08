//
//  EmergencyContactsView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct EmergencyContactsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "phone.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text("Emergency Contacts")
                .font(.poppins(fontStyle: .subheadline, fontWeight: .bold))
            
            Text("Important emergency contact numbers for campus security, medical services, and crisis support.")
                .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                EmergencyContactRow(title: "Campus Security", number: "123-456-7890")
                EmergencyContactRow(title: "Medical Emergency", number: "911")
                EmergencyContactRow(title: "Student Support", number: "123-456-7891")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Emergency Contacts")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EmergencyContactRow: View {
    let title: String
    let number: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.poppins(fontStyle: .callout, fontWeight: .semibold))
                Text(number)
                    .font(.poppins(fontStyle: .caption, fontWeight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                if let url = URL(string: "tel://\(number.replacingOccurrences(of: "-", with: ""))") {
                    UIApplication.shared.open(url)
                }
            }) {
                Image(systemName: "phone.fill")
                    .foregroundColor(.green)
                    .font(.title3)
            }
        }
    }
}

#Preview {
    EmergencyContactsView()
}
