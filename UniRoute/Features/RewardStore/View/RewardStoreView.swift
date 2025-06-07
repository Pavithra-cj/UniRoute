//
//  RewardStoreView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct RewardStoreView: View {
    @StateObject private var viewModel = RewardsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Tab Selection
            TabSelectionView(
                selectedTab: $viewModel.selectedTab,
                tabs: RewardsViewModel.RewardsTab.allCases
            )
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // Content Area
            ScrollView {
                VStack(spacing: 20) {
                    switch viewModel.selectedTab {
                    case .giftCard:
                        GiftCardsGridView(
                            items: viewModel.giftItems,
                            onGiftRedeemed: viewModel.redeemGiftCard
                        )
                        .padding(.horizontal, 20)
                        
                    case .history:
                        HistoryListView(items: viewModel.historyItems)
                            .padding(.horizontal, 20)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct TabSelectionView: View {
    @Binding var selectedTab: RewardsViewModel.RewardsTab
    let tabs: [RewardsViewModel.RewardsTab]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: 8) {
                        Text(tab.rawValue)
                            .font(.system(size: 16, weight: selectedTab == tab ? .semibold : .medium))
                            .foregroundColor(selectedTab == tab ? .primary : .secondary)
                        
                        Rectangle()
                            .fill(selectedTab == tab ? Color.blue : Color.clear)
                            .frame(height: 2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.clear)
    }
}

struct GiftCardsGridView: View {
    let items: [GiftItem]
    let onGiftRedeemed: (GiftItem) -> Void
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(items) { item in
                GiftCardView(
                    item: item,
                    onGetTapped: {
                        onGiftRedeemed(item)
                    }
                )
            }
        }
    }
}

struct HistoryListView: View {
    let items: [HistoryItem]
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(items) { item in
                HistoryCard(item: item)
            }
        }
    }
}

#Preview {
    RewardStoreView()
}
