//
//  LoginViewController.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private enum Constants {
        static let textFieldHeight: CGFloat = 29
        static let loginButtonHeight: CGFloat = 46
        static let vStackViewLeading: CGFloat = 20
        static let vStackViewTrailing: CGFloat = -20
        static let vStackViewCenterYoffset: CGFloat = -100
        static let vStackViewHeightMultiplier: CGFloat = 0.4
        static let textFieldsStackViewSpacing: CGFloat = 35
        static let secureButtonTrailing: CGFloat = -10
    }
        
    private let titleLabel = CustomLabel(.loginTitle)
    
    private let firstNameTextField = CustomTextField(.firstname)
    
    private let passwordTextField = CustomTextField(.password)
    
    private lazy var secureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: ThemeImages.systemPasswordEye),
                        for: .normal)
        button.setImage(UIImage(systemName: ThemeImages.systemPasswordSlashEye),
                        for: .selected)
        button.isSelected = true
        
        button.contentMode = .scaleAspectFit
        button.tintColor = .gray
        button.addAction(UIAction(handler: { _ in
            self.secureButton.isSelected.toggle()
            self.passwordTextField.isSecureTextEntry.toggle()
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton = CustomButton(.loginButtonLoginScreen, action: loginButtonTapped())
    
    private lazy var textFieldsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstNameTextField,
            passwordTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.textFieldsStackViewSpacing
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            textFieldsVStackView,
            loginButton
        ])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegates()
    }
    
    private func loginButtonTapped() -> UIAction {
        UIAction { [weak self] _ in
            guard let self = self else { return }
            
            let username = UserDefaults.standard.value(UserModel.self, forKey: UserDefaultsKeys.user.rawValue)?.firstname
            if username == self.firstNameTextField.text {
                self.saveUserData()
                let vc = AppCoordinator().start()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            } else {
                self.showAlert(title: LocalizedStrings.userIsntExistTitle,
                               message: LocalizedStrings.userIsntExistTitle) { _ in
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    private func saveUserData() {
        let user = UserDefaults.standard.value(UserModel.self, forKey: UserDefaultsKeys.user.rawValue)
        user?.isLogged = true
        UserDefaults.standard.set(encodable: user, forKey: UserDefaultsKeys.user.rawValue)
    }
    
    private func setDelegates() {
        firstNameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = ThemeColor.backgroundColor
        
        view.addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(secureButton)
        
        NSLayoutConstraint.activate([
            vStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.vStackViewHeightMultiplier),
            vStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.vStackViewCenterYoffset),
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.vStackViewLeading),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.vStackViewTrailing)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: Constants.loginButtonHeight),
            passwordTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            firstNameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            secureButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            secureButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: Constants.secureButtonTrailing)
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}



