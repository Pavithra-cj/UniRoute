//
//  SliderView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct AutoSlider: View {
    let items: [SliderItem]
    @Binding var currentIndex: Int
    
    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $currentIndex) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    SlideView(item: item)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)
            .cornerRadius(16)
            
            // Custom page indicator
            HStack(spacing: 8) {
                ForEach(0..<items.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.blue : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                        .animation(.easeInOut(duration: 0.3), value: currentIndex)
                }
            }
        }
    }
}

struct SlideView: View {
    let item: SliderItem
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                startPoint: .bottom,
                endPoint: .center
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.horizontal, 20)
            }
            .padding(20)
        }
        .cornerRadius(16)
    }
}
