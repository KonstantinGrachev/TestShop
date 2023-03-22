//
//  HintTableViewCell.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 20.03.2023.
//

import UIKit

final class HintTableViewCell: UITableViewCell {
    
    static let cellID = "HintTableViewCell"
    
    private enum Constants {
        static let hintLabelLeadingAnchor: CGFloat = 10
        static let hintLabelTrailingAnchor: CGFloat = -10
    }
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        hintLabel.text = text
    }
    
    private func setupUI() {
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hintLabel)
        
        NSLayoutConstraint.activate([
            hintLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            hintLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.hintLabelLeadingAnchor),
            hintLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.hintLabelTrailingAnchor)
        ])
    }
}
