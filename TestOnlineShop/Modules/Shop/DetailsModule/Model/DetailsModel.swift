//
//  DetailsModel.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import Foundation

// MARK: - Details
struct Details: Codable {
    let name, description: String
    let rating: Double
    let numberOfReviews, price: Int
    let colors: [String]
    let imageUrls: [String]

    enum CodingKeys: String, CodingKey {
        case name, description, rating
        case numberOfReviews = "number_of_reviews"
        case price, colors
        case imageUrls = "image_urls"
    }
}
