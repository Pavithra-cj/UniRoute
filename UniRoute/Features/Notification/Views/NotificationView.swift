//
//  NotificationView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct NotificationView: View {
    @StateObject private var viewModel = NotificationViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.unreadCount > 0 {
                    HStack {
                        Text("\(viewModel.unreadCount) unread notifications")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Button("Mark all as read") {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.markAllAsRead()
                            }
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color(UIColor.systemGroupedBackground))
                }
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.notifications) { notification in
                            NotificationCardView(
                                notification: notification,
                                onTap: {
                                    viewModel.markAsRead(notification)
                                },
                                onActionTap: {
                                    viewModel.handleNotificationAction(notification)
                                },
                                onDelete: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        viewModel.deleteNotification(notification)
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 0)
                    .padding(.bottom, 40)
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
//            .navigationBarHidden(true)
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.large)
        }
//        .navigationBarBackButtonHidden(true)
//        .ignoresSafeArea(.container, edges: .top)
    }
}

#Preview {
    NotificationView()
}
