//
//  CustomBackgroundView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

enum CustomBackgroundViewType {
    
    case empty
    
    case roundedIntoCategoryCell
    
    case plusMinusButtonInDetails,
         addToCartButtonInDetails,
         bottomBackgroundViewInDetails,
         detailsLargePhotoSeparatorView
    
    var color: UIColor {
        switch self {
        case .empty:
            return .blue
        case .plusMinusButtonInDetails,
                .addToCartButtonInDetails:
            return ThemeColor.buttonBackgroundColor
        case .bottomBackgroundViewInDetails:
            return ThemeColor.cartDarkBackgroundColor
        case .roundedIntoCategoryCell:
            return ThemeColor.buttonSecondaryBackgroundColor
        case .detailsLargePhotoSeparatorView:
            return ThemeColor.buttonIconTintColor
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .empty: return 10
        case .plusMinusButtonInDetails: return 8
        case .addToCartButtonInDetails: return 15
        default: return 0
        }
    }
}

final class CustomBackgroundView: UIView {
    
    private var type: CustomBackgroundViewType = .empty
    
    convenience init(_ type: CustomBackgroundViewType) {
        self.init(frame: .zero)
        self.layer.cornerRadius = type.cornerRadius
        self.backgroundColor = type.color
    }
    
    convenience init(_ type: CustomBackgroundViewType, forRounded cornerRadius: CGFloat) {
        self.init(frame: .zero)
        self.layer.cornerRadius = type.cornerRadius
        self.backgroundColor = type.color
        
        switch type {
        case .roundedIntoCategoryCell:
            self.layer.cornerRadius = cornerRadius / 2
        default: break
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
