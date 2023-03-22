//
//  MainViewModel.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import Foundation
import Combine

protocol MainViewModelDelegate: AnyObject {
    func updateData()
}

final class MainViewModel: MainViewModelProtocol {
    
    private var coordinator: MainBaseCoordinator
    
    weak var delegate: MainViewModelDelegate?
    
    var searchText = CurrentValueSubject<String, Never>("")
    var searchResult: AnyPublisher<[String], Error> {
        return searchResultSubject.eraseToAnyPublisher()
    }

    private(set) var searchResultSubject = PassthroughSubject<[String], Error>()
    private var searchTask: Cancellable?
    
    private var sale = [SaleItem]()
    private var latest = [LatestItem]()
    private var brands = [LatestItem]()
    
    private let productCategoriesDataSource: [ProductCategoryItem] = [
        .init(title: LocalizedStrings.phonesCategory, imageName: ThemeImages.phone),
        .init(title: LocalizedStrings.headphonesCategory, imageName: ThemeImages.headphones),
        .init(title: LocalizedStrings.gamesCategory, imageName: ThemeImages.games),
        .init(title: LocalizedStrings.carsCategory, imageName: ThemeImages.cars),
        .init(title: LocalizedStrings.furnitureCategory, imageName: ThemeImages.furniture),
        .init(title: LocalizedStrings.kidsCategory, imageName: ThemeImages.kids)
    ]
    
    var pageData: [MainListSection]? = nil {
        didSet {
            delegate?.updateData()
        }
    }
    
    private let group = DispatchGroup()
    
    init(coordinator: MainBaseCoordinator) {
        self.coordinator = coordinator
        self.fetchData()
    }
    
    func moveToDetails() {
        coordinator.moveTo(flow: .main(.detailsScreen), userData: ["title": ""])
    }
    
    func fetchSearchingData() {
        searchTask?.cancel()

        let searchTerm = searchText.value.replacingOccurrences(of: " ", with: "")

        guard !searchTerm.isEmpty,
        let request = RequestType.search.request else { return }
                
        searchTask = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, _ -> [String] in
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                return result.words
            }
            .map {
                $0.filter { $0.contains(searchTerm) } }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in self?.searchResultSubject.send($0) })
    }
    
    private func fetchData() {
        var latestData = [LatestElement]() {
            didSet {
                latestData.forEach { [weak self] latestItem in
                    guard let self = self else { return }
                    group.enter()
                    ImageDownloaderManager.shared.fetchImage(from: latestItem.imageURL) { image in
                        let latestItem = LatestItem(category: latestItem.category,
                                                    name: latestItem.name,
                                                    price: latestItem.price,
                                                    image: image)
                        self.latest.append(latestItem)
                        self.group.leave()
                    }
                }
            }
        }
        
        var saleData = [FlashSale]() {
            didSet {
                saleData.forEach { [weak self] saleItem in
                    guard let self = self else { return }
                    group.enter()
                    ImageDownloaderManager.shared.fetchImage(from: saleItem.imageURL) { image in
                        let saleItem = SaleItem(category: saleItem.category,
                                                name: saleItem.name,
                                                price: saleItem.price,
                                                discount: saleItem.discount,
                                                image: image)
                        self.sale.append(saleItem)
                        self.group.leave()
                    }
                }
            }
        }
        
        group.enter()
        NetworkService.shared.getLatest { [weak self] in
            latestData = $0.latest
            self?.group.leave()
        }
        group.enter()
        NetworkService.shared.getSale { [weak self] in
            saleData = $0.flashSale
            self?.group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.pageData = [
                .categories(self.productCategoriesDataSource),
                .latest(self.latest),
                .sales(self.sale),
                .brands(self.latest)
            ]
        }
    }
}
