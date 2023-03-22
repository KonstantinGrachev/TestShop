//
//  ProfileViewModel.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import Foundation

final class ProfileViewModel: ProfileViewModelProtocol {

    var coordinator: ProfileBaseCoordinator
    
    var user = UserDefaults.standard.value(UserModel.self, forKey: UserDefaultsKeys.user.rawValue)
    
    init(coordinator: ProfileBaseCoordinator) {
        self.coordinator = coordinator
    }
    
}
