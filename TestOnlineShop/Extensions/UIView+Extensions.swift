//
//  UIView+Extensions.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

extension UIView {

    func dropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 7
    }
    
    func dropВDetailsImageShadow(isSelected: Bool?) {
        guard let isSelected = isSelected else { return }
        if isSelected {
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: 0, height: 5)
            layer.shadowRadius = 2
            layer.shadowColor = UIColor.black.cgColor
        } else {
            layer.shadowColor = UIColor.clear.cgColor
        }
    }
}
