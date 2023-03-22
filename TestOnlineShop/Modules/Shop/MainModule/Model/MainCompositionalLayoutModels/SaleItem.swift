//
//  SaleItem.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 19.03.2023.
//

import UIKit

final class SaleItem {
    let category, name: String
    let price: Double
    let discount: Int
    let image: UIImage
    
    init(category: String, name: String, price: Double, discount: Int, image: UIImage) {
        self.category = category
        self.name = name
        self.price = price
        self.discount = discount
        self.image = image
    }
}
