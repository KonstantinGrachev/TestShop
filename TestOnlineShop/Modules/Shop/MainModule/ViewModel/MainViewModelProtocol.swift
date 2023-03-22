//
//  MainViewModelProtocol.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import Foundation
import Combine

protocol MainViewModelProtocol {
    var pageData: [MainListSection]? { get set }
    var delegate: MainViewModelDelegate? { get set }
    var searchText: CurrentValueSubject<String, Never> { get }
    var searchResult: AnyPublisher<[String], Error> { get }
    func fetchSearchingData()
    func moveToDetails()
}
