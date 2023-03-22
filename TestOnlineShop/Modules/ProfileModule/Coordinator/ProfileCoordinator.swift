//
//  ProfileCoordinator.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 15.03.2023.
//

import UIKit

class ProfileCoordinator: ProfileBaseCoordinator {
    
    var parentCoordinator: BaseCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let vc = ProfileViewController()
        vc.viewModel = ProfileViewModel(coordinator: self)
        rootViewController = UINavigationController(rootViewController: vc)
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .profile(let screen):
            handleProfileFlow(for: screen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleProfileFlow(for screen: ProfileScreen, userData: [String : Any]? = nil) {
        switch screen {
        case .firstScreen:
            resetToRoot(animated: false)
        }
    }
   
    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
}
