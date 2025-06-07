//
//  PlaceCard.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct PlaceCardView: View {
    var place: Place
    @State private var isFavorite: Bool = false
    @State private var showDetailPopup: Bool = false
    @EnvironmentObject var mapViewModel: MapViewModel
    @Binding var selectedTab: TabBar.TabItem
    
    init(place: Place, selectedTab: Binding<TabBar.TabItem> = .constant(.home)) {
        self.place = place
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(place.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 100)
                    .clipped()
                
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .white)
                        .padding(8)
                        .background(Circle().fill(Color.white.opacity(0.7)))
                }
                .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.blue)
                    
                    Text(place.name)
                        .font(
                            .poppins(
                                fontStyle: .footnote,
                                fontWeight: .semibold
                            )
                        )
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                
                Text(place.floor)
                    .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                HStack {
                    Text("\(place.distance)m")
                        .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                }
                
                if !place.crowdLevel.isEmpty {
                    Text("Crowd level")
                        .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                        .foregroundColor(.gray)
                    
                    Text(place.crowdLevel)
                        .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                        .foregroundColor(place.crowdLevel == "Very Crowded" ? .red : .green)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            place.crowdLevel == "Very Crowded" ? Color.red.opacity(0.1) : Color.green.opacity(0.1)
                        )
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        .onTapGesture {
            showDetailPopup = true
        }
        .fullScreenCover(isPresented: $showDetailPopup) {
            ZStack {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                
                PlaceDetailPopup(
                    place: place,
                    selectedTab: Binding<TabBar.TabItem?>(
                        get: { self.selectedTab },
                        set: { if let newValue = $0 { self.selectedTab = newValue } }
                    )
                )
                .environmentObject(mapViewModel)
            }
            .background(BackgroundClearView())
        }
    }
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    PlaceCardView(
        place: Place(
            name: "Harrison Hall",
            floor: "Computing Faculty",
            distance: 10,
            crowdLevel: "Not Crowded",
            startTime: "13:30",
            date: "01/02/2025",
            image: "lecHall_image"
        )
    )
    .environmentObject(MapViewModel())
    .frame(width: 200, height: 250)
    .padding()
}
