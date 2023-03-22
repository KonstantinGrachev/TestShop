//
//  SignInViewModelProtocol.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 15.03.2023.
//

import Foundation
import Combine

protocol SignInViewModelProtocol: AnyObject {
    var firstname: String { get set }
    var lastname: String { get set}
    var email: String { get set }
    var isSignUpEnabled: AnyPublisher<Bool, Never> { get }
    
    func saveUser()
    func isExistUsername(name: String?) -> Bool 
}
