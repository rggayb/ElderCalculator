//
//  FontExtension.swift
//  ElderCalculator
//
//  Created by Vincent Saranang on 09/07/24.
//

import Foundation
import SwiftUI

extension Font {
    static func sf(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let fontName: String
        
        switch weight {
        case .heavy:
            fontName = "SFProDisplay-Heavy"
        case .bold:
            fontName = "SFProDisplay-Bold"
        case .semibold:
            fontName = "SFProDisplay-Semibold"
        case .medium:
            fontName = "SFProDisplay-Medium"
        case .light:
            fontName = "SFProDisplay-Light"
        case .ultraLight:
            fontName = "SFProDisplay-Ultralight"
        case .thin:
            fontName = "SFProDisplay-Thin"
        default:
            fontName = "SFProDisplay-Regular"
        }
        
        return .custom(fontName, size: size)
    }
}
