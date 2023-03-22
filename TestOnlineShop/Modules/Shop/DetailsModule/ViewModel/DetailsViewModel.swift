//
//  DetailsViewModel.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

protocol DetailsViewModelDelegate: AnyObject {
    func updateData()
}

final class DetailsViewModel {
    
    var coordinator: MainBaseCoordinator
    
    weak var delegate: DetailsViewModelDelegate?
    
    var info: DetailsInfo? = nil
    
    var pageDataSource: [DetailsListSection]? = nil {
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
        coordinator.moveTo(flow: .main(.detailsScreen), userData: ["title": "detali"])
    }
    
    func fetchData() {
        var photoItems = [PhotoItem]()
        var colors = [ColorItem]()
        
        group.enter()
        var imageUrls = [String]() {
            didSet {
                imageUrls.forEach {
                    
                    group.enter()
                    ImageDownloaderManager.shared.fetchImage(from: $0) { [weak self] in
                        photoItems.append(PhotoItem(photo: $0, isSelectedPhoto: false))
                        self?.group.leave()
                    }
                }
            }
        }
        
        NetworkService.shared.getDetails { [weak self] in
            imageUrls = $0.imageUrls
            $0.colors.forEach { colors.append(ColorItem(color: UIColor(hex: $0),
                                                        isSelectedColor: false)) }
            self?.info = DetailsInfo(name: $0.name,
                                     description: $0.description,
                                     rating: $0.rating,
                                     numberOfReviews: $0.numberOfReviews,
                                     price: $0.price)
            self?.group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.pageDataSource = [
                .large(photoItems),
                .small(photoItems),
                .info(self?.info),
                .color(colors)
            ]
        }
    }
}

extension DetailsViewModel: DetailsViewModelProtocol {
    func moveToCart() {
        coordinator.moveTo(flow: .main(.cartScreen), userData: ["String" : ""])
    }
}
