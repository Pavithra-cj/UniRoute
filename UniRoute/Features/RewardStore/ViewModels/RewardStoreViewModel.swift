//
//  RewardStoreViewModel.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

class RewardsViewModel: ObservableObject {
    @Published var currentPoints: Int = 50
    @Published var selectedTab: RewardsTab = .giftCard
    @Published var giftItems: [GiftItem] = []
    @Published var historyItems: [HistoryItem] = []
    
    enum RewardsTab: String, CaseIterable {
        case giftCard = "Gift Cards"
        case history = "History"
    }
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        giftItems = [
            GiftItem(title: "Dialog LKR 50 Reload", imageName: "Dialog_logo", points: 50),
            GiftItem(title: "Dialog LKR 100 Reload", imageName: "Dialog_logo", points: 100),
            GiftItem(title: "Dialog LKR 200 Reload", imageName: "Dialog_logo", points: 200),
            GiftItem(title: "Dialog LKR 119 Reload", imageName: "Dialog_logo", points: 119),
            GiftItem(title: "Dialog LKR 239 Reload", imageName: "Dialog_logo", points: 239),
        ]
        
        historyItems = [
            HistoryItem(
                title: "Trip Completed",
                description: "Lecture Hall 2 to Library 1",
                points: 25,
                date: Date().addingTimeInterval(-86400),
                type: .earned
            ),
            HistoryItem(
                title: "Dialog Reload Redeemed",
                description: "LKR 50 mobile reload",
                points: -50,
                date: Date().addingTimeInterval(-172800),
                type: .redeemed
            ),
            HistoryItem(
                title: "Daily Check-in",
                description: "Daily login bonus",
                points: 10,
                date: Date().addingTimeInterval(-259200),
                type: .earned
            ),
            HistoryItem(
                title: "Crowd Level Sharing",
                description: "Shared crowd level",
                points: 15,
                date: Date().addingTimeInterval(-345600),
                type: .earned
            ),
            HistoryItem(
                title: "Dialog Reload Redeemed",
                description: "LKR 200 mobile reload",
                points: -200,
                date: Date().addingTimeInterval(-432000),
                type: .redeemed
            )
        ]
    }
    
    func redeemGiftCard(_ item: GiftItem) {
        guard currentPoints >= item.points else { return }
        
        currentPoints -= item.points
        
        let newHistoryItem = HistoryItem(
            title: "\(item.title) Redeemed",
            description: "Gift card redemption",
            points: -item.points,
            date: Date(),
            type: .redeemed
        )
        
        historyItems.insert(newHistoryItem, at: 0)
    }
}
