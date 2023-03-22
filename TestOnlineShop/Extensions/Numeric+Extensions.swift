//
//  Numeric+Extensions.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 17.03.2023.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
