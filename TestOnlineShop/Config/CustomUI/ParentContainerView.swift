//
//  ParentContainerView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import UIKit

class ParentContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
}
