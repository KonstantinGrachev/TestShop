//
//  ColorItem.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 19.03.2023.
//

import UIKit

final class ColorItem {
    let color: UIColor
    var isSelectedColor: Bool
    
    init(color: UIColor, isSelectedColor: Bool) {
        self.color = color
        self.isSelectedColor = isSelectedColor
    }
}
