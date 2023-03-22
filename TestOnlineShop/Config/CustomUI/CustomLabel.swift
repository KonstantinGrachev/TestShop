//
//  CustomLabel.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

enum CustomLabelType {
    case empty,
         
         //login, signin
         loginTitle,
         loginTitleLabel,
    
         signInTitle,
         supplementaryViewTitle,
         categoryLabel,
         
         profileTitleLabel,
         profileMenuLabel,
         profileName,
         
         //cells
         nameIntoLatestCell,
         categoryIntoLatestCell,
         priceIntoLatestCell,
    
         saleOffIntoCell,
         nameIntoSaleCell,
         categoryIntoSaleCell,
         priceIntoSaleCell,
    
         //details
         quantityTitleLabel,
         detailsTotalLabel,
         detailsColorSupplementaryViewTitle,
         
         detailsNameIntoCell,
         detailsPriceIntoCell,
         detailsDescriptionIntoCell,
         detailsRateIntoDetails,
         detailsReviewsIntoLabel
    
    
    var aligment: NSTextAlignment {
        switch self {
        case .loginTitle,
             .signInTitle,
             .profileTitleLabel,
             .categoryLabel,
             .profileName:
            return .center
        case .saleOffIntoCell:
            return .right
        default:
            return .left
        }
    }
    
    var font: UIFont? {
        switch self {
        case .loginTitle,
             .signInTitle,
             .profileTitleLabel,
             .profileName:
            return ThemeFont.titleFont()
        case .loginTitleLabel:
            return ThemeFont.primaryFont()
        case .supplementaryViewTitle:
            return ThemeFont.supplementaryHeaderFont()
        case .categoryLabel:
            return ThemeFont.categoryFont()
        case .profileMenuLabel:
            return ThemeFont.profileMenuLabelFont()
        case .nameIntoLatestCell:
            return ThemeFont.nameIntoLatestCell()
        case .categoryIntoLatestCell:
            return ThemeFont.categoryIntoLatestCell()
        case .priceIntoLatestCell:
            return ThemeFont.priceIntoLatestCell()
        case .saleOffIntoCell:
            return ThemeFont.saleOffIntoCell()
        case .nameIntoSaleCell:
            return ThemeFont.nameIntoSaleCell()
        case .priceIntoSaleCell:
            return ThemeFont.priceIntoSaleCell()
        case .categoryIntoSaleCell:
            return ThemeFont.categoryIntoSaleCell()
        case .detailsTotalLabel:
            return ThemeFont.detailsTotalLabel()
        case .detailsColorSupplementaryViewTitle:
            return ThemeFont.detailsColorSupplementaryViewTitle()
        case .detailsNameIntoCell:
            return ThemeFont.detailsNameIntoCell()
        case .detailsPriceIntoCell:
            return ThemeFont.detailsPriceIntoCell()
        case .detailsDescriptionIntoCell, .detailsReviewsIntoLabel:
            return ThemeFont.detailsDescriptionIntoCell()
        case .detailsRateIntoDetails:
            return ThemeFont.detailsRateIntoDetails()
        case .quantityTitleLabel:
            return ThemeFont.quantityTitleLabel()

        default:
            return .systemFont(ofSize: 14)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .nameIntoSaleCell,
            .nameIntoLatestCell,
            .priceIntoSaleCell,
            .priceIntoLatestCell,
            .saleOffIntoCell:
            return .white
        case .categoryLabel,
             .loginTitleLabel:
            return ThemeColor.specialGrayTextColor
        case .detailsTotalLabel:
            return ThemeColor.detailsPriceLabel
        case .quantityTitleLabel,
                .detailsColorSupplementaryViewTitle,
                .detailsDescriptionIntoCell,
                .detailsReviewsIntoLabel:
            return .gray
        default:
            return .black
        }
    }
    
    var text: String {
        switch self {
        
        case .loginTitle:
            return LocalizedStrings.loginTitle
        case .loginTitleLabel:
            return LocalizedStrings.loginTitleLabel
        case .signInTitle:
            return LocalizedStrings.signInTitle
        case .profileTitleLabel:
            return LocalizedStrings.profileTitleLabel
        default: return ""
        }
    }
}

final class CustomLabel: UILabel {
    private var type: CustomLabelType = .empty
    
    convenience init(_ type: CustomLabelType) {
        self.init(frame: .zero)
        textColor = type.textColor
        font = type.font
        textAlignment = type.aligment
        numberOfLines = 0
        text = type.text
        adjustsFontSizeToFitWidth = true
        
        switch type {
        case .signInTitle:
            dropShadow()
        case .profileName:
            text = LocalizedStrings.unknownUser
        case .detailsPriceIntoCell:
            textAlignment = .right
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
