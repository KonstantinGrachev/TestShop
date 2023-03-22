//
//  DetailsListSection.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 17.03.2023.
//

import UIKit

enum DetailsListSection {
    case large([PhotoItem]?),
         small([PhotoItem]?),
         info(DetailsInfo?),
         color([ColorItem]?)
    
    
    var photoItems: [PhotoItem]? {
        switch self {
        case .large(let large):
            return large
        case .small(let small):
            return small
        default: return nil
        }
    }
    
    var infoItems: DetailsInfo? {
        switch self {
        case .info(let infoItem):
            return infoItem
        default: return nil
        }
    }
    
    var colorItems: [ColorItem]? {
        switch self {
            case .color(let color):
            return color
        default: return nil
        }
    }
    
    var count: Int {
        switch self {
        case .large:
            return photoItems?.count ?? 0
        case .small:
            return photoItems?.count ?? 0
        case .info:
            if infoItems != nil {
                return 1
            } else {
                return 0
            }
        case .color:
            return colorItems?.count ?? 0
        }
    }
    
    var title: String {
        switch self {
        case .color:
            return "Color"
        default: return ""
        }
    }
    
}
