//
//  SplashScreenView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-06.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.5
    
    var body: some View {
        ZStack{
            if isActive {
                LoginView()
            }else {
                Image("bgSplash")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.2)
                    .background(Color.black)
                
                VStack{
                    Spacer()
                    
                    ZStack{
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 260, height: 260)
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 270,
                                   height: 270)
                    }
                    
                    HStack(spacing: 0){
                        Text("Uni")
                            .font(
                                .poppins(
                                    fontStyle: .largeTitle, fontWeight: .heavy
                                )
                            )
                            .foregroundStyle(.white)
                        
                        Text("Route")
                            .font(
                                .poppins(
                                    fontStyle: .largeTitle,
                                    fontWeight: .heavy
                                )
                            )
                            .foregroundStyle(.blue)
                    }
                    Text("Campus Navigator")
                        .font(
                            .poppins(fontStyle: .caption, fontWeight: .medium)
                        )
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear() {
                    withAnimation(.easeInOut(duration: 1.2)) {
                        self.opacity = 1.0
                        self.scale = 1.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
