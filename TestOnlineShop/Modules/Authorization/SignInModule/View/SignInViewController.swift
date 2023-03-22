//
//  SignInViewController.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 12.03.2023.
//

import UIKit
import Combine

final class SignInViewController: UIViewController {
    
    private enum Constants {
        static let vStackViewLeading: CGFloat = 40
        static let vStackViewTrailing: CGFloat = -40
    }
    
    var viewModel: SignInViewModelProtocol
    private var cancellable = Set<AnyCancellable>()
    
    private let bottomButtonsContainerView = BottomButtonsContainerView()
    private let containerTitleView = SignInTopContainerView()
    private let middleContainerView = MiddleContainerView()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            containerTitleView,
            middleContainerView,
            bottomButtonsContainerView
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    init(viewModel: SignInViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegates()
        bindUIwithViewModel()
    }
    
    private func bindUIwithViewModel() {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: middleContainerView.firstNameTextField)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .assign(to: \.firstname, on: viewModel)
            .store(in: &cancellable)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: middleContainerView.lastNameTextField)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .assign(to: \.lastname, on: viewModel)
            .store(in: &cancellable)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: middleContainerView.emailTextField)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellable)

        viewModel.isSignUpEnabled
            .assign(to: \.isEnabled, on: middleContainerView.signInButton) //проверяем на то будет ли доступна кнопка
            .store(in: &cancellable)
    }
    
    private func setDelegates() {
        middleContainerView.actionsDelegate = self
        middleContainerView.textFieldsDelegate = self
        bottomButtonsContainerView.actionsDelegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = ThemeColor.backgroundColor
        
        view.addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.vStackViewLeading),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.vStackViewTrailing),
            vStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        view.endEditing(true)
        return true
    }
}

extension SignInViewController: MiddleContainerViewActionsDelegate, BottomButtonsContainerViewActionsDelegate {
    func signInButtonTapped() {
        
        if viewModel.isExistUsername(name: middleContainerView.firstNameTextField.text) {
            showAlert(title: LocalizedStrings.userAlreadyExistTitle,
                      message: LocalizedStrings.userAlreadyExistMessage)
        } else {
            viewModel.saveUser()
            let vc = AppCoordinator().start()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            removeFromParent()
        }
    }
    
    func loginButtonTapped() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func signInWithGoogleButtonTapped() {
        print(#function)
    }
    
    func signInWithAppleButtonTapped() {
        print(#function)
    }
}
