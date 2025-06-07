//
//  NotificationModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let timestamp: Date
    let type: NotificationType
    let isRead: Bool
    let actionData: NotificationActionData?
    
    enum NotificationType {
        case reward
        case route
        case system
        case promotion
        case reminder
        
        var icon: String {
            switch self {
            case .reward: return "gift.fill"
            case .route: return "map.fill"
            case .system: return "gear.circle.fill"
            case .promotion: return "tag.fill"
            case .reminder: return "bell.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .reward: return .orange
            case .route: return .blue
            case .system: return .gray
            case .promotion: return .purple
            case .reminder: return .green
            }
        }
        
        var backgroundColor: Color {
            return color.opacity(0.1)
        }
    }
}

struct NotificationActionData {
    let actionTitle: String
    let actionType: ActionType
    
    enum ActionType {
        case viewRoute
        case claimReward
        case viewDetails
        case openSettings
    }
}
