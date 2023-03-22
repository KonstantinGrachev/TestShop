//
//  LatestItem.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 19.03.2023.
//

import UIKit

final class LatestItem {
    let category, name: String
    let price: Int
    let image: UIImage
    
    init(category: String, name: String, price: Int, image: UIImage) {
        self.category = category
        self.name = name
        self.price = price
        self.image = image
    }
}
