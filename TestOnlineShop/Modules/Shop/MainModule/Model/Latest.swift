//
//  Latest.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import Foundation

struct Latest: Codable {
    let latest: [LatestElement]
}

struct LatestElement: Codable {
    let category, name: String
    let price: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case category, name, price
        case imageURL = "image_url"
    }
}
