//
//  MyAlert.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-01.
//

import SwiftUI

struct MyAlert: View {
    var message: String
    var style: AlertStyle
    var duration: Double = 3.0
    var onDismiss: () -> Void = {}
    
    @State private var isShowing = false
    
    enum AlertStyle {
        case success, error, warning, info
        
        var iconName: String {
            switch self {
            case .success: return "checkmark.circle.fill"
            case .error: return "xmark.circle.fill"
            case .warning: return "exclamationmark.triangle.fill"
            case .info: return "info.circle.fill"
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .success: return Color.green
            case .error: return Color.red
            case .warning: return Color.orange
            case .info: return Color.blue
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image(systemName: style.iconName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(message)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Button(action: {
                    dismissToast()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(style.backgroundColor)
            )
            .shadow(color: style.backgroundColor.opacity(0.3), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 16)
            .opacity(isShowing ? 1 : 0)
            .offset(y: isShowing ? 0 : -20)
            
            Spacer()
        }
        .padding(.top, getSafeAreaTop())
        .onAppear {
            showToast()
        }
    }
    
    private func showToast() {
        withAnimation(.spring()) {
            isShowing = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            dismissToast()
        }
    }
    
    private func dismissToast() {
        withAnimation(.easeOut(duration: 0.2)) {
            isShowing = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onDismiss()
        }
    }
    
    private func getSafeAreaTop() -> CGFloat {
#if canImport(UIKit)
        if let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .filter({ $0.isKeyWindow }).first {
            return keyWindow.safeAreaInsets.top
        }
#endif
        return 0
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let style: MyAlert.AlertStyle
    let duration: Double
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                MyAlert(
                    message: message,
                    style: style,
                    duration: duration,
                    onDismiss: {
                        isPresented = false
                    }
                )
                .transition(.opacity)
                .zIndex(100)
            }
        }
    }
}

extension View {
    func customToast(isPresented: Binding<Bool>, message: String, style: MyAlert.AlertStyle = .success, duration: Double = 3.0) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, style: style, duration: duration))
    }
}
