//
//  BottomButtonsContainerView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import UIKit

protocol BottomButtonsContainerViewActionsDelegate: AnyObject {
    func signInWithGoogleButtonTapped()
    func signInWithAppleButtonTapped()
}

final class BottomButtonsContainerView: ParentContainerView {
    
    weak var actionsDelegate: BottomButtonsContainerViewActionsDelegate?
    
    private let googleSignInButton = CustomButton(.signInWithGoogle, action: UIAction { _ in
        print(#function)
    })
    
    private let appleSignInButton = CustomButton(.signInWithApple, action: UIAction { _ in
        print(#function)
    })
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            googleSignInButton,
            appleSignInButton
        ])
        stackView.axis = .vertical
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
    
    private func signInButtonTapped(_ sender: UIButton) -> UIAction {
        UIAction { [weak self] _ in
            switch sender {
            case self?.googleSignInButton:
                self?.actionsDelegate?.signInWithGoogleButtonTapped()
            case self?.appleSignInButton:
                self?.actionsDelegate?.signInWithAppleButtonTapped()
            default:
                break
            }
        }
    }
    
    private func setupUI() {
        
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vStackView)
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
