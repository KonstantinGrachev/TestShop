//
//  SignInViewModel.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import Combine
import UIKit

final class SignInViewModel: SignInViewModelProtocol {
    
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var email = ""
    
    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isEmail() }
            .eraseToAnyPublisher()
    }
    
    var isValidFirstnamePublisher: AnyPublisher<Bool, Never> {
        $lastname
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isValidLastnamePublisher: AnyPublisher<Bool, Never> {
        $lastname
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isSignUpEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isValidFirstnamePublisher,
                                  isValidLastnamePublisher,
                                  isValidEmailPublisher)
            .map { $0 && $1 && $2 }
            .eraseToAnyPublisher()
    }
    
    func saveUser() {
        let user = UserModel(firstname: firstname.trimmingCharacters(in: .whitespaces),
                                lastname: lastname.trimmingCharacters(in: .whitespaces),
                                email: email.trimmingCharacters(in: .whitespaces),
                                image: UIImage(named: ThemeImages.userphoto)?.toPngString(),
                                isLogged: true)
        UserDefaults.standard.set(encodable: user, forKey: UserDefaultsKeys.user.rawValue)
    }
    
    func isExistUsername(name: String?) -> Bool {
        let databaseUsername = UserDefaults.standard.value(UserModel.self, forKey: UserDefaultsKeys.user.rawValue)?.firstname
        return name == databaseUsername
    }
}
