//
//  GiftCardView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-08.
//

import SwiftUI

struct GiftCardView: View {
    let item: GiftItem
    var onGetTapped: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .foregroundColor(.blue)
                .padding(.top, 16)
            
            Text(item.title)
                .font(.system(size: 14, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
            
            Spacer()
            
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "medal.fill")
                        .foregroundColor(Color.yellow)
                        .font(.system(size: 14))
                    
                    Text("\(item.points)")
                        .font(.system(size: 14, weight: .medium))
                }
                
                Spacer()
                
                Button(action: {
                    onGetTapped?()
                }) {
                    Text("Get")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 70, height: 32)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 20)
        }
        .frame(height: 180)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// Preview
struct GiftCardView_Previews: PreviewProvider {
    static var previews: some View {
        GiftCardView(
            item: GiftItem(
                title: "Dialog LKR 50 Reload",
                imageName: "Dialog_logo",
                points: 50
            )
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
