//
//  DetailsViewModelProtocol.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 17.03.2023.
//

import Foundation

protocol DetailsViewModelProtocol {
    var pageDataSource: [DetailsListSection]? { get set }
    var delegate: DetailsViewModelDelegate? { get set }
    var info: DetailsInfo? { get set }
    func fetchData()
    func moveToCart()
}
