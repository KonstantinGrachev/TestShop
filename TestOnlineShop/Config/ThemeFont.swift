//
//  ThemeFont.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

struct ThemeFont {
    //regular
    static func primaryFont() -> UIFont? {
        UIFont(heavy: .regular, size: 10)
    }
    
    static func plusMinusDetailsButton() -> UIFont? {
        UIFont(heavy: .regular, size: 14)
    }
    
    static func signInWithButtonFont() -> UIFont? {
        UIFont(heavy: .regular, size: 12)
    }
    
    static func placeholderFont() -> UIFont? {
        UIFont(heavy: .regular, size: 12)
    }
    
    static func profileMenuLabelFont() -> UIFont? {
        UIFont(heavy: .regular, size: 14)
    }
    
    static func categoryFont() -> UIFont? {
        UIFont(heavy: .regular, size: 8)
    }
    
    //bold
    static func saleOffIntoCell() -> UIFont? {
        UIFont(heavy: .bold, size: 10)
    }
    
    static func titleFont() -> UIFont {
        UIFont(heavy: .bold, size: 24) ?? .systemFont(ofSize: 24)
    }
    
    static func buttonFont() -> UIFont? {
        UIFont(heavy: .bold, size: 14)
    }
    
    static func detailsHeaderFont() -> UIFont? {
        UIFont(heavy: .bold, size: 16)
    }
    
    static func supplementaryHeaderFont() -> UIFont? {
        UIFont(heavy: .bold, size: 16)
    }
    
    //light
    static func detailsPrimaryFont() -> UIFont? {
        UIFont(heavy: .light, size: 10)
    }
    
    static func detailsDescriptionIntoCell() -> UIFont? {
        UIFont(heavy: .light, size: 12)
    }
    
    //searchbar
    static func searchbar() -> UIFont? {
        UIFont(heavy: .light, size: 12)
    }
    
    //cells fonts
    static func nameIntoLatestCell() -> UIFont? {
        UIFont(heavy: .bold, size: 8)
    }
    
    static func categoryIntoLatestCell() -> UIFont? {
        UIFont(heavy: .bold, size: 6)
    }
    
    static func priceIntoLatestCell() -> UIFont? {
        UIFont(heavy: .bold, size: 6)
    }
    
    static func nameIntoSaleCell() -> UIFont? {
        UIFont(heavy: .bold, size: 12)
    }
    
    static func priceIntoSaleCell() -> UIFont? {
        UIFont(heavy: .bold, size: 10)
    }
    
    static func categoryIntoSaleCell() -> UIFont? {
        UIFont(heavy: .bold, size: 9)
    }
    
    static func detailsColorSupplementaryViewTitle() -> UIFont? {
        UIFont(heavy: .bold, size: 10)
    }
    
    static func detailsNameIntoCell() -> UIFont? {
        UIFont(heavy: .bold, size: 16)
    }
    
    static func detailsPriceIntoCell() -> UIFont? {
        UIFont(heavy: .bold, size: 14)
    }
    
    //details
    static func detailsTotalLabel() -> UIFont? {
        UIFont(heavy: .bold, size: 12)
    }
    
    static func addToCartButton() -> UIFont? {
        UIFont(heavy: .bold, size: 8)
    }
    
    static func detailsRateIntoDetails() -> UIFont? {
        UIFont(heavy: .bold, size: 12)
    }
    
    static func quantityTitleLabel() -> UIFont? {
        UIFont(heavy: .bold, size: 12)
    }
}
