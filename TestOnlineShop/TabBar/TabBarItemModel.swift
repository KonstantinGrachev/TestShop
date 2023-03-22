//
//  TabBarItemModel.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 15.03.2023.
//

import UIKit

final class TabBarItemModel {
    let viewController: UIViewController
    let coordinator: Coordinator?
    let image: UIImage?
    let unselectedImage: UIImage?
    let appCoordinator: AppCoordinator?

    init(viewController: UIViewController, coordinator: Coordinator?, image: UIImage?, unselectedImage: UIImage?, appCoordinator: AppCoordinator?) {
        self.viewController = viewController
        self.coordinator = coordinator
        self.image = image
        self.unselectedImage = unselectedImage
        self.appCoordinator = appCoordinator
    }
}
