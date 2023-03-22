//
//  SignInTopContainerView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import UIKit

final class SignInTopContainerView: ParentContainerView {
    
    private let titleLabel = CustomLabel(.signInTitle)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
