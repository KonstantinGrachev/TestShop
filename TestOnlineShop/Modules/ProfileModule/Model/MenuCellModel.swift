//
//  MenuCellModel.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 22.03.2023.
//

import Foundation

final class MenuCellModel {
    let title: String
    let iconName: String
    let disclosureIconName: String?
    let disclosureImageName: String?
    let disclosure: String
    
    init(title: String, iconName: String, disclosureIconName: String?, disclosureText: String?, disclosure: String) {
        self.title = title
        self.iconName = iconName
        self.disclosureIconName = disclosureIconName
        self.disclosureImageName = disclosureText
        self.disclosure = disclosure

    }
}
