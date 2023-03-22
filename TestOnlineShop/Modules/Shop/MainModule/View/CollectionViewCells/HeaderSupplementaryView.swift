//
//  HeaderSupplementaryView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 16.03.2023.
//

import UIKit

final class HeaderSupplementaryView: UICollectionReusableView {
    
    static let cellID = "HeaderSupplementaryView"
    
    enum Constants {
        static let leadingInset: CGFloat = 10
        static let trailingInset: CGFloat = -10
    }
    
    private let headerLabel = CustomLabel(.supplementaryViewTitle)
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray
        button.setTitle(LocalizedStrings.supplementaryViewTitleButton, for: .normal)
        button.addAction(UIAction(handler: { _ in
            print(#function)
        }), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with textHeader: String?) {
        headerLabel.text = textHeader
    }
    
    private func setupUI() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)

        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingInset)
        ])
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.trailingInset)
        ])
    }
}
