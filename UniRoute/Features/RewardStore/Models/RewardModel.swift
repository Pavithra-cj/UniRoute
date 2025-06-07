//
//  RewardModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct HistoryItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let points: Int
    let date: Date
    let type: HistoryType
    
    enum HistoryType {
        case earned
        case redeemed
        
        var icon: String {
            switch self {
            case .earned: return "plus.circle.fill"
            case .redeemed: return "minus.circle.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .earned: return .green
            case .redeemed: return .orange
            }
        }
    }
}

struct GiftItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let points: Int
}
