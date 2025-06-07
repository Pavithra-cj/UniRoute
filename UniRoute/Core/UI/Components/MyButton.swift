//
//  MyButton.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-01.
//

import SwiftUI

enum ButtonVariant {
    case primary
    case secondary
    case outline
}

enum ButtonSize {
    case xs
    case sm
    case md
    case lg
}

enum ButtonWidth {
    case fixed(CGFloat)
    case flexible
    case full
}

struct MyButton: View {
    let title: String
    let variant: ButtonVariant
    let size: ButtonSize
    let width: ButtonWidth
    let action: () -> Void
    
    init(
        title: String,
        variant: ButtonVariant = .primary,
        size: ButtonSize = .md,
        width: ButtonWidth = .full,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.size = size
        self.width = width
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(fontForSize)
                .fontWeight(.medium)
                .frame(maxWidth: widthForType)
                .padding(paddingForSize)
        }
        .background(backgroundForVariant)
        .foregroundStyle(foregroundForVariant)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderForVariant, lineWidth: variant == .outline ? 2 : 0)
        )
    }
    
    private var widthForType: CGFloat? {
        switch width {
        case .fixed(let width):
            return width
        case .flexible:
            return nil
        case .full:
            return .infinity
        }
    }
    
    private var fontForSize: Font {
        switch size {
        case .xs:
            return .poppins(fontStyle: .footnote, fontWeight: .bold)
        case .sm:
            return .poppins(fontStyle: .caption, fontWeight: .bold)
        case .md:
            return .poppins(fontStyle: .callout, fontWeight: .bold)
        case .lg:
            return .poppins(fontStyle: .body, fontWeight: .bold)
        }
    }
    
    private var paddingForSize: EdgeInsets {
        switch size {
        case .xs:
            return EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
        case .sm:
            return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        case .md:
            return EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        case .lg:
            return EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
        }
    }
    
    private var backgroundForVariant: Color {
        switch variant {
        case .primary:
            return Color.blue
        case .secondary:
            return Color.gray.opacity(0.2)
        case .outline:
            return Color.clear
        }
    }
    
    private var foregroundForVariant: Color {
        switch variant {
        case .primary:
            return Color.white
        case .secondary, .outline:
            return Color.blue
        }
    }
    
    private var borderForVariant: Color {
        switch variant {
        case .outline:
            return Color.blue
        default:
            return Color.clear
        }
    }
}
