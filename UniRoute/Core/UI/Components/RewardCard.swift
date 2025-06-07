//
//  RewardCard.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct RewardCard: View {
    var points: Int
    @State private var progress: Double = 0.4
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("You've earned")
                    .font(.poppins(fontStyle: .title3, fontWeight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color.yellow.opacity(0.8))
                            .frame(width: 24, height: 24)
                            .offset(x: -4, y: -2)
                        
                        Circle()
                            .fill(Color.yellow.opacity(0.9))
                            .frame(width: 24, height: 24)
                            .offset(x: -2, y: -1)
                        
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 24, height: 24)
                        
                        Text("$")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.orange)
                    }
                    
                    Text("\(points)")
                        .font(
                            .poppins(
                                fontStyle: .headline,
                                fontWeight: .medium
                            )
                        )
                        .foregroundColor(.white)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Reward Progress")
                    .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.75 * progress, height: 8)
                }
                
                HStack {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Text("$")
                                .font(
                                    .poppins(
                                        fontStyle: .callout,
                                        fontWeight: .bold
                                    )
                                )
                                .foregroundColor(.orange)
                        )
                    
                    Spacer()
                    
                    Text("40/100")
                        .font(
                            .poppins(fontStyle: .caption, fontWeight: .medium)
                        )
                        .foregroundColor(.white)
                }
                
                Text("complete the progress to withdraw points")
                    .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 2)
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.3, green: 0.6, blue: 1.0),
                    Color(red: 0.2, green: 0.5, blue: 0.9)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
}

// Preview
struct RewardCard_Previews: PreviewProvider {
    static var previews: some View {
        RewardCard(
            points: 50
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
