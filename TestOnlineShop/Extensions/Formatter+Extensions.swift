//
//  Formatter+Extensions.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 17.03.2023.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}
