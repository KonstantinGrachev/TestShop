//
//  AppCoordinator.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

enum AppFlow {
    case main(MainScreen),
         profile(ProfileScreen)
}

enum MainScreen {
    case shopScreen,
         detailsScreen,
         cartScreen
}

enum ProfileScreen {
    case firstScreen
}

class AppCoordinator: BaseCoordinator {
    
    var parentCoordinator: BaseCoordinator?
    
    lazy var mainCoordinator: MainBaseCoordinator = MainCoordinator()
    lazy var profileCoordinator: ProfileBaseCoordinator = ProfileCoordinator()
  
    lazy var rootViewController: UIViewController = UITabBarController()
    
    lazy var tabBarItems = [
        TabBarItemModel(viewController: mainCoordinator.start(),
                        coordinator: mainCoordinator,
                        image: UIImage(named: ThemeImages.home),
                        unselectedImage: UIImage(named: ThemeImages.homeUnselected),
                        appCoordinator: self
                       ),
        TabBarItemModel(viewController: MockFavouritesViewController(),
                        coordinator: nil,
                        image: UIImage(named: ThemeImages.heart),
                        unselectedImage: UIImage(named: ThemeImages.heartUnselected),
                        appCoordinator: self
                       ),
        TabBarItemModel(viewController: MockCartViewController(),
                        coordinator: nil,
                        image: UIImage(named: ThemeImages.cart),
                        unselectedImage: UIImage(named: ThemeImages.cartUnselected),
                        appCoordinator: self
                       ),
        TabBarItemModel(viewController: MockChatViewController(),
                        coordinator: nil,
                        image: UIImage(named: ThemeImages.chat),
                        unselectedImage: UIImage(named: ThemeImages.chatUnselected),
                        appCoordinator: self
                       ),
        TabBarItemModel(viewController: profileCoordinator.start(),
                        coordinator: profileCoordinator,
                        image: UIImage(named: ThemeImages.profile),
                        unselectedImage: UIImage(named: ThemeImages.profileUnselected),
                        appCoordinator: self
                       )
    ]
      
    var tabBar = MainTabBarController()
    
    func start() -> UIViewController {
        tabBar.configureWith(appCoordinator: self)
        rootViewController = tabBar
        return rootViewController
        
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .main:
            print(#function)
        case .profile:
            print(#function)
        }
    }
}
