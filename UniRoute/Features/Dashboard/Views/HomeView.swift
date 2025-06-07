//
//  HomeView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct HomeView: View {
    @State private var hasUnreadNotifications = true
    @Binding var selectedTab: TabBar.TabItem
    @State private var searchText = ""
    
    @StateObject private var mapViewModel = MapViewModel()
    @StateObject private var dashboardViewModel = DashboardViewModel()
    
    init(selectedTab: Binding<TabBar.TabItem> = .constant(.home)) {
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header Section
                    HeaderView(
                        studentName: dashboardViewModel.userName,
                        hasUnreadNotifications: hasUnreadNotifications
                    )
                    
                    //Reward Card
                    NavigationLink(destination: RewardStoreView()) {
                        RewardCard(points: dashboardViewModel.userPoints)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("Next Event")
                        .font(.poppins(fontStyle: .body, fontWeight: .semibold))
                        .padding(.horizontal)
                    
                    // Next Event Card
                    NavigationLink(destination: LectureScheduleView()) {
                        NextEventCard(event: dashboardViewModel.nextEvent)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .foregroundColor(.black)
                        Text("Most searched places")
                            .font(
                                .poppins(
                                    fontStyle: .callout,
                                    fontWeight: .semibold
                                )
                            )
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(dashboardViewModel.searchedPlaces, id: \.name) { place in
                                PlaceCardView(place: place, selectedTab: $selectedTab)
                                    .environmentObject(mapViewModel)
                                    .frame(width: 160)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.top, 0)
                .padding(.horizontal, 16)
            }
            .background(Color.white)
            .navigationBarHidden(true)
            .onAppear {
                mapViewModel.places = dashboardViewModel.searchedPlaces
            }
        }
        .environmentObject(dashboardViewModel)
    }
}

#Preview {
    HomeView()
}
