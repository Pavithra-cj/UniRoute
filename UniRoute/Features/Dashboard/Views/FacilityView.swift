//
//  FacilityView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct FacilityView: View {
    @StateObject private var viewModel = FacilityViewModel()
    @State private var selectedTab: TabBar.TabItem? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Campus Navigation")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Find and navigate to campus facilities")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    
                    // Auto Slider
                    AutoSlider(
                        items: viewModel.sliderItems,
                        currentIndex: $viewModel.currentSliderIndex
                    )
                    .padding(.horizontal, 20)
                    
                    // Facilities Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Campus Facilities")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button("View All") {
                                // Handle view all action
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal, 20)
                        
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.facilities) { facility in
                                FacilityCard(facility: facility) {
                                    viewModel.selectPlace(facility)
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                }
                .padding(.vertical, 20)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
        .sheet(
            isPresented: $viewModel.showPlaceDetail
        ) {
            if let selectedPlace = viewModel.selectedPlace {
                PlaceDetailPopup(
                    place: selectedPlace,
                    selectedTab: $selectedTab
                )
                .environmentObject(MapViewModel())
            }
        }
        .background(BackgroundClearView())
    }
}


#Preview {
    FacilityView()
}
