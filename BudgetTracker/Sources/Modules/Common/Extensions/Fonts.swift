//
//  Fonts.swift
//  BudgetTracker
//
//  Created by FoxxFire on 23.10.2025.
//

import UIKit

extension UIFont {
    static func inter(size: CGFloat, weight: CGFloat) -> UIFont {
        // weight: 300 = Light, 400 = Regular, 500 = Medium, 600 = SemiBold, 700 = Bold
        let fontName = "Inter-VariableFont_opsz,wght"
        
        if let descriptor = UIFontDescriptor(name: fontName, size: size)
            .withDesign(.default)?
            .addingAttributes([
                .traits: [UIFontDescriptor.TraitKey.weight: weight]
            ]) {
            return UIFont(descriptor: descriptor, size: size)
        }
        
        // Fallback на системные шрифты
        switch weight {
        case 300...350:
            return .systemFont(ofSize: size, weight: .light)
        case 351...450:
            return .systemFont(ofSize: size, weight: .regular)
        case 451...550:
            return .systemFont(ofSize: size, weight: .medium)
        case 551...650:
            return .systemFont(ofSize: size, weight: .semibold)
        default:
            return .systemFont(ofSize: size, weight: .regular)
        }
    }
    
    // Удобные методы для часто используемых стилей
    static func interLight(size: CGFloat) -> UIFont {
        return inter(size: size, weight: 300) // Light
    }
    
    static func interRegular(size: CGFloat) -> UIFont {
        return inter(size: size, weight: 400) // Regular
    }
    
    static func interMedium(size: CGFloat) -> UIFont {
        return inter(size: size, weight: 500) // Medium
    }
    
    static func interSemiBold(size: CGFloat) -> UIFont {
        return inter(size: size, weight: 600) // SemiBold
    }
    
    static func interBold(size: CGFloat) -> UIFont {
        return inter(size: size, weight: 700) // Bold
    }
}
