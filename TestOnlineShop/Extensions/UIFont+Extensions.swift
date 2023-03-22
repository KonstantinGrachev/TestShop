//
//  UIFont+Extensions.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

extension UIFont {
    enum MontserratHeavy {
        case regular, bold, light
        
        var fontName: String {
            switch self {
            case .regular:
                return "Montserrat-Regular"
            case .bold:
                return "Montserrat-Bold"
            case .light:
                return "Montserrat-Light"
            }
        }
    }
    
    convenience init?(heavy: MontserratHeavy, size: CGFloat) {
        self.init(name: heavy.fontName, size: size)
    }
}
