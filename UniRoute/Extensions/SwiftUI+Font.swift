//
//  SwiftUI+Font.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-01.
//

import SwiftUI

extension Font {
    static func poppins(fontStyle: Font.TextStyle = .body, fontWeight: Weight = .regular) -> Font {
        return Font
            .custom(
                CustomFont(weight: fontWeight).rawValue,
                size: fontStyle.size
            )
    }
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return 48
        case .title: return 34
        case .title2: return 30
        case .title3: return 28
        case .headline: return 24
        case .subheadline: return 20
        case .body: return 18
        case .callout: return 16
        case .caption: return 14
        case .footnote: return 12
        case .caption2: return 10
        @unknown default:
            return 16
        }
    }
}

enum CustomFont: String {
    case poppinsRegular = "Poppins-Regular"
    case poppinsMedium = "Poppins-Medium"
    case poppinsSemiBold = "Poppins-SemiBold"
    case poppinsBold = "Poppins-Bold"
    case poppinsLight = "Poppins-Light"
    case poppinsThin = "Poppins-Thin"
    case poppinsBlack = "Poppins-Black"
    case poppinsBlackItalic = "Poppins-BlackItalic"
    case poppinsBoldItalic = "Poppins-BoldItalic"
    case allantRegular = "Allant-Regular"
    case allanBold = "Allan-Bold"
    
    init(weight: Font.Weight){
        switch weight {
        case .ultraLight:
            self = .allantRegular
        case .regular:
            self = .allanBold
        case .black:
            self = .poppinsBlack
        case .light:
            self = .poppinsLight
        case .thin:
            self = .poppinsThin
        case .medium:
            self = .poppinsMedium
        case .semibold:
            self = .poppinsSemiBold
        case .bold:
            self = .poppinsBold
        case .heavy:
            self = .poppinsBlackItalic
        default:
            self = .poppinsRegular
        }
    }
}
