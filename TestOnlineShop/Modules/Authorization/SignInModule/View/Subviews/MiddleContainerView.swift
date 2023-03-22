//
//  TextFieldsContainerView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import UIKit

protocol MiddleContainerViewActionsDelegate: AnyObject {
    func signInButtonTapped()
    func loginButtonTapped()
}

final class MiddleContainerView: ParentContainerView {
    
    weak var actionsDelegate: MiddleContainerViewActionsDelegate?
    
    weak var textFieldsDelegate: UITextFieldDelegate? {
        didSet {
            setDelegates()
        }
    }
    
    private enum Constants {
        static let textFieldHeight: CGFloat = 29
        static let textFieldsStackViewSpacing: CGFloat = 30
        static let signInButtonHeight: CGFloat = 46
        static let insetBetweenButtonAndStackView: CGFloat = 30
        static let insetBetweenButtonAndLabel: CGFloat = 10
    }
        
    let firstNameTextField = CustomTextField(.firstname)
    let lastNameTextField = CustomTextField(.lastname)
    let emailTextField = CustomTextField(.email)
    
    private let loginTitleLabel = CustomLabel(.loginTitleLabel)
    
    lazy var loginButton = CustomButton(
        .loginButtonSignScreen,
        action: UIAction { [weak self] _ in
            self?.actionsDelegate?.loginButtonTapped()
        })

    
    lazy var signInButton = CustomButton(
        .signInButton,
        action: UIAction { [weak self] _ in
            self?.actionsDelegate?.signInButtonTapped()
        })
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstNameTextField,
            lastNameTextField,
            emailTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.textFieldsStackViewSpacing
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        firstNameTextField.delegate = textFieldsDelegate
        lastNameTextField.delegate = textFieldsDelegate
        emailTextField.delegate = textFieldsDelegate
    }
    
    private func setupUI() {
        let subviews = [
            vStackView,
            signInButton,
            loginButton,
            loginTitleLabel
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            loginTitleLabel.trailingAnchor.constraint(equalTo: loginButton.leadingAnchor, constant: Constants.insetBetweenButtonAndLabel),
            loginTitleLabel.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: vStackView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            signInButton.topAnchor.constraint(equalTo: vStackView.bottomAnchor, constant: Constants.insetBetweenButtonAndStackView)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            firstNameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            lastNameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            signInButton.heightAnchor.constraint(equalToConstant: Constants.signInButtonHeight)
        ])
    }
}
