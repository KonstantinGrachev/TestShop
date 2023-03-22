//
//  ListSection.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 15.03.2023.
//

import Foundation

enum MainListSection {
    
    case categories([ProductCategoryItem])
    case latest([LatestItem]?)
    case sales([SaleItem]?)
    case brands([LatestItem]?)
    
    var categoriesItems: [ProductCategoryItem]? {
        switch self {
        case .categories(let categories):
            
            return categories
        default: return nil
        }
    }
    
    var salesItems: [SaleItem]? {
        switch self {
        case .sales(let sales):
            
            return sales
        default: return nil
        }
    }
    
    var latestItems: [LatestItem]? {
        switch self {
        case .latest(let latest):
            
            return latest
        default: return nil
        }
    }
    
    var brandsItems: [LatestItem]? {
        switch self {
        case .brands(let brands):
            
            return brands
        default: return nil
        }
    }
    
    var count: Int {
        switch self {
            
        case .categories:
            return categoriesItems?.count ?? 0
        case .sales:
            return salesItems?.count ?? 0
        case .latest:
            return latestItems?.count ?? 0
        case .brands:
            return brandsItems?.count ?? 0
        }
    }
    
    var title: String {
        switch self {
        case .categories:
            return ""
        case .latest:
            return LocalizedStrings.latest
        case .sales:
            return LocalizedStrings.flashSale
        case .brands:
            return LocalizedStrings.brands
        }
    }
}
