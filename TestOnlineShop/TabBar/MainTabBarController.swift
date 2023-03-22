//
//  MainTabBarController.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private var appCoordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
    }
    
    override func viewWillLayoutSubviews() {
        setTabBar(tabBarItems: appCoordinator?.tabBarItems)
    }
    
    func configureWith(appCoordinator: AppCoordinator?) {
        self.appCoordinator = appCoordinator
    }
    
    private func setTabBar(tabBarItems: [TabBarItemModel]?) {
        var viewControllers = [UIViewController]()
        guard let items = tabBarItems else { return }
        items.forEach {
            let vc = generateVC(viewController: $0.viewController,
                       coordinator: $0.coordinator,
                       image: $0.image,
                                unselectedImage: $0.unselectedImage,
                                appCoordinator: $0.appCoordinator)
            viewControllers.append(vc)
        }
        self.viewControllers = viewControllers
    }
    
    private func generateVC(viewController: UIViewController,
                            coordinator: Coordinator?,
                            image: UIImage?,
                            unselectedImage: UIImage?, appCoordinator: AppCoordinator?) -> UIViewController {
        viewController.tabBarItem.selectedImage = image?.withRenderingMode(.alwaysOriginal)
        coordinator?.parentCoordinator = appCoordinator
        viewController.tabBarItem.image = unselectedImage
        
        return viewController
    }
    
    private func setTabBarAppearance() {
        let width = tabBar.bounds.width
        let height: CGFloat = tabBar.bounds.height * 2
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: tabBar.bounds.minX,
                y: tabBar.bounds.minY - 10,
                width: width,
                height: height
            ),
            cornerRadius: 20
        )
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        roundLayer.fillColor = ThemeColor.backgroundColor.cgColor
        tabBar.unselectedItemTintColor = ThemeColor.tabBarUnselectedColor
    }
}
