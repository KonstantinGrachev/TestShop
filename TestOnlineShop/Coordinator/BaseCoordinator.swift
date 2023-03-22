//
//  BaseCoordinator.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 15.03.2023.
//

import Foundation

protocol BaseCoordinator: Coordinator {
    var mainCoordinator: MainBaseCoordinator { get }
    var profileCoordinator: ProfileBaseCoordinator { get }
}
