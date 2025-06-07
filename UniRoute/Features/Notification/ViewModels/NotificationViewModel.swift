//
//  NotificationViewModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = []
    @Published var unreadCount: Int = 0
    
    init() {
        loadMockNotifications()
        updateUnreadCount()
    }
    
    private func loadMockNotifications() {
        notifications = [
            NotificationItem(
                title: "Reward Earned! 🎉",
                message: "You've earned 25 points for completing your trip from Colombo to Kandy. Keep exploring!",
                timestamp: Date().addingTimeInterval(-300),
                type: .reward,
                isRead: false,
                actionData: NotificationActionData(
                    actionTitle: "View Rewards",
                    actionType: .claimReward
                )
            ),
            NotificationItem(
                title: "New Route Available",
                message: "A faster route to your destination has been found. Check it out to save 15 minutes!",
                timestamp: Date().addingTimeInterval(-1800),
                type: .route,
                isRead: false,
                actionData: NotificationActionData(
                    actionTitle: "View Route",
                    actionType: .viewRoute
                )
            ),
            NotificationItem(
                title: "Special Offer - 50% Off! 🏷️",
                message: "Limited time offer: Get 50% extra points on all gift card redemptions this weekend.",
                timestamp: Date().addingTimeInterval(-7200),
                type: .promotion,
                isRead: true,
                actionData: NotificationActionData(
                    actionTitle: "Shop Now",
                    actionType: .viewDetails
                )
            ),
            NotificationItem(
                title: "Daily Check-in Reminder",
                message: "Don't forget to check in today to earn your daily bonus points!",
                timestamp: Date().addingTimeInterval(-14400),
                type: .reminder,
                isRead: false,
                actionData: NotificationActionData(
                    actionTitle: "Check In",
                    actionType: .claimReward
                )
            ),
            NotificationItem(
                title: "App Update Available",
                message: "Version 2.1.0 is now available with bug fixes and performance improvements.",
                timestamp: Date().addingTimeInterval(-86400),
                type: .system,
                isRead: true,
                actionData: NotificationActionData(
                    actionTitle: "Update",
                    actionType: .openSettings
                )
            ),
            NotificationItem(
                title: "Route Completed Successfully",
                message: "Your journey from Galle to Matara has been completed. Thank you for using UniRoute!",
                timestamp: Date().addingTimeInterval(-172800),
                type: .route,
                isRead: true,
                actionData: nil
            ),
            NotificationItem(
                title: "Weekly Summary Available",
                message: "Your weekly travel summary is ready. You've traveled 150km this week and earned 75 points!",
                timestamp: Date().addingTimeInterval(-259200),
                type: .system,
                isRead: true,
                actionData: NotificationActionData(
                    actionTitle: "View Summary",
                    actionType: .viewDetails
                )
            ),
            NotificationItem(
                title: "Friend Joined UniRoute! 👋",
                message: "Your friend Sarah has joined UniRoute using your referral code. You've earned 50 bonus points!",
                timestamp: Date().addingTimeInterval(-345600),
                type: .reward,
                isRead: true,
                actionData: nil
            )
        ]
    }
    
    func markAsRead(_ notification: NotificationItem) {
        if let index = notifications.firstIndex(where: { $0.id == notification.id }) {
            notifications[index] = NotificationItem(
                title: notification.title,
                message: notification.message,
                timestamp: notification.timestamp,
                type: notification.type,
                isRead: true,
                actionData: notification.actionData
            )
            updateUnreadCount()
        }
    }
    
    func markAllAsRead() {
        notifications = notifications.map { notification in
            NotificationItem(
                title: notification.title,
                message: notification.message,
                timestamp: notification.timestamp,
                type: notification.type,
                isRead: true,
                actionData: notification.actionData
            )
        }
        updateUnreadCount()
    }
    
    func deleteNotification(_ notification: NotificationItem) {
        notifications.removeAll { $0.id == notification.id }
        updateUnreadCount()
    }
    
    private func updateUnreadCount() {
        unreadCount = notifications.filter { !$0.isRead }.count
    }
    
    func handleNotificationAction(_ notification: NotificationItem) {
        guard let actionData = notification.actionData else { return }
        
        switch actionData.actionType {
        case .viewRoute:
            print("Opening route view...")
        case .claimReward:
            print("Opening rewards...")
        case .viewDetails:
            print("Opening details...")
        case .openSettings:
            print("Opening settings...")
        }
        
        markAsRead(notification)
    }
}
