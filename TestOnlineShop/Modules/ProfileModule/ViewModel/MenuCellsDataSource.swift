//
//  MenuCellsDataSource.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import UIKit

enum ProfileMenuDisclosureType: String {
    case tradeStore, paymentMethod, balance, tradeHistory, restorePurchase, help, logout
}

final class MenuCellsDataSource {
    static let menuItems = [
        MenuCellModel(title: LocalizedStrings.tradeStoreTitle,
                      iconName: ThemeImages.card,
                      disclosureIconName: ThemeImages.systemChevronRight,
                      disclosureText: nil,
                      disclosure: ProfileMenuDisclosureType.tradeStore.rawValue),
        
        MenuCellModel(title: LocalizedStrings.paymentMethodTitle,
                      iconName: ThemeImages.card,
                      disclosureIconName: ThemeImages.systemChevronRight,
                      disclosureText: nil,
                      disclosure: ProfileMenuDisclosureType.paymentMethod.rawValue),
        
        MenuCellModel(title: LocalizedStrings.balanceTitle,
                      iconName: ThemeImages.card,
                      disclosureIconName: nil,
                      disclosureText: "$ 13232",
                      disclosure: ProfileMenuDisclosureType.balance.rawValue),
        
        MenuCellModel(title: LocalizedStrings.tradeHistoryTitle,
                      iconName: ThemeImages.card,
                      disclosureIconName: ThemeImages.systemChevronRight,
                      disclosureText: nil,
                      disclosure: ProfileMenuDisclosureType.tradeHistory.rawValue),
        
        MenuCellModel(title: LocalizedStrings.restorePurchaseTitle,
                      iconName: ThemeImages.restorePurchaseIcon,
                      disclosureIconName: ThemeImages.systemChevronRight,
                      disclosureText: nil,
                      disclosure: ProfileMenuDisclosureType.restorePurchase.rawValue),
        
        MenuCellModel(title: LocalizedStrings.helpTitle,
                      iconName: ThemeImages.help,
                      disclosureIconName: nil,
                      disclosureText: nil,
                      disclosure: ProfileMenuDisclosureType.help.rawValue),
        
        MenuCellModel(title: LocalizedStrings.logOutTitle,
                      iconName: ThemeImages.logout,
                      disclosureIconName: nil,
                      disclosureText: nil,
                      disclosure: ProfileMenuDisclosureType.logout.rawValue)
    ]
}
