//
//  DetailsColorSupplementaryView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 19.03.2023.
//

import UIKit

final class DetailsColorSupplementaryView: UICollectionReusableView {
    
    static let cellID = "DetailsColorSupplementaryView"
    
    enum Constants {
        static let leadingInset: CGFloat = 10
        static let trailingInset: CGFloat = -10
    }
    
    private let headerLabel = CustomLabel(.detailsColorSupplementaryViewTitle)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with textHeader: String?) {
        headerLabel.text = textHeader
    }
    
    private func setupUI() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingInset)
        ])
    }
}
