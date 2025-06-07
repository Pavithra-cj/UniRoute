//
//  TabBar.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: TabItem
    
    enum TabItem {
        case home, map, facility, profile
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            // Home Tab
            VStack(spacing: 4) {
                Image(systemName: "house")
                    .font(.system(size: 20))
                Text("Home")
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(selectedTab == .home ? .black : .gray)
            .onTapGesture {
                selectedTab = .home
            }
            
            Spacer()
            
            // Browse Tab
            VStack(spacing: 4) {
                Image(systemName: "map")
                    .font(.system(size: 20))
                Text("Map")
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(selectedTab == .map ? .black : .gray)
            .onTapGesture {
                selectedTab = .map
            }
            
            Spacer()
            
            // Queue Tab
            VStack(spacing: 4) {
                Image(systemName: "building")
                    .font(.system(size: 20))
                Text("Facility")
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(selectedTab == .facility ? .black : .gray)
            .onTapGesture {
                selectedTab = .facility
            }
            
            Spacer()
            
            // Account Tab
            VStack(spacing: 4) {
                Image(systemName: "person")
                    .font(.system(size: 20))
                Text("Account")
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(selectedTab == .profile ? .black : .gray)
            .onTapGesture {
                selectedTab = .profile
            }
            
            Spacer()
        }
        .padding(.vertical, 10)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
        )
    }
}

// Preview
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            TabBar(selectedTab: .constant(.home))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
