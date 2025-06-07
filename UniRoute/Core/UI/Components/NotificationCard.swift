//
//  NotificationCard.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct NotificationCardView: View {
    let notification: NotificationItem
    let onTap: () -> Void
    let onActionTap: () -> Void
    let onDelete: () -> Void
    
    @State private var showingDeleteAlert = false
    
    private var timeAgoFormatter: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: notification.timestamp, relativeTo: Date())
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: notification.type.icon)
                    .font(.system(size: 24))
                    .foregroundColor(notification.type.color)
                    .frame(width: 44, height: 44)
                    .background(notification.type.backgroundColor)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(notification.title)
                            .font(.system(size: 16, weight: notification.isRead ? .medium : .semibold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if !notification.isRead {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 8, height: 8)
                        }
                    }
                    
                    Text(notification.message)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(timeAgoFormatter)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .padding(.top, 2)
                }
                
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.secondary.opacity(0.6))
                }
            }
            .padding(16)
            .background(notification.isRead ? Color.white : Color.blue.opacity(0.02))
            .onTapGesture {
                onTap()
            }
            
            if let actionData = notification.actionData {
                Divider()
                
                HStack {
                    Spacer()
                    
                    Button(action: onActionTap) {
                        Text(actionData.actionTitle)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .alert("Delete Notification", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                onDelete()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this notification?")
        }
    }
}
