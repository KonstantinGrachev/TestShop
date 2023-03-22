//
//  SceneDelegate.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let isLogged = (UserDefaults.standard.value(UserModel.self, forKey: UserDefaultsKeys.user.rawValue))?.isLogged ?? false
        
        if isLogged {
            window?.rootViewController = AppCoordinator().start()

        } else {
            let viewModel = SignInViewModel()
            let vc = SignInViewController(viewModel: viewModel)
            window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
    }
}

