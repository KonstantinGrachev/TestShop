//
//  MainCoordinator.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 15.03.2023.
//

import UIKit

class MainCoordinator: MainBaseCoordinator {

    var parentCoordinator: BaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        
        let vc = MainViewController()
        vc.viewModel = MainViewModel(coordinator: self)
        rootViewController = UINavigationController(rootViewController: vc)
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .main(let screen):
            handleMainFlow(for: screen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleMainFlow(for screen: MainScreen, userData: [String: Any]?) {
        switch screen {
        case .shopScreen:
            navigationRootViewController?.popToRootViewController(animated: true)
        case .detailsScreen:
            guard let title = userData?["title"] as? String else { return }
            goToDetailsScreenWith(title: title)
        case .cartScreen:
            goToCartScreen()
        }
    }
    
    func goToDetailsScreenWith(title: String) {
        let viewModel = DetailsViewModel(coordinator: self)
        let detailsViewController = DetailsViewController()
        detailsViewController.viewModel = viewModel
        detailsViewController.title = title
        navigationRootViewController?.pushViewController(detailsViewController, animated: true)
    }
    
    func goToCartScreen() {
        let cartViewController = MockCartViewController()
        navigationRootViewController?.pushViewController(cartViewController, animated: true)
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}
