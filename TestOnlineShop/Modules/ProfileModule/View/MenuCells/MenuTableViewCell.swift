//
//  MenuTableViewCell.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import UIKit

final class MenuTableViewCell: UITableViewCell {
    
    static let cellID = "MenuTableViewCell"
    
    var disclosure: String?
    
    private enum Constants {
        static let backgroundButtonViewHeightWidth: CGFloat = 40
        static let iconImageViewHeightWidth: CGFloat = 22
        static let titleLabelLeadingAnchor: CGFloat = 10
    }
    
    private let backgroundButtonView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.backgroundButtonViewHeightWidth / 2
        view.backgroundColor = ThemeColor.buttonSecondaryBackgroundColor
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private let titleLabel = CustomLabel(.profileMenuLabel)
    
    private let disclosureIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private let disclosureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        let subviews = [
        backgroundButtonView,
        iconImageView,
        titleLabel,
        disclosureIconImageView,
        disclosureLabel
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundButtonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundButtonView.heightAnchor.constraint(equalToConstant: Constants.backgroundButtonViewHeightWidth),
            backgroundButtonView.widthAnchor.constraint(equalToConstant: Constants.backgroundButtonViewHeightWidth),
            backgroundButtonView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconImageViewHeightWidth),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconImageViewHeightWidth),
            iconImageView.centerYAnchor.constraint(equalTo: backgroundButtonView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: backgroundButtonView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            disclosureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            disclosureLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            disclosureIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            disclosureIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundButtonView.trailingAnchor,
                                                constant: Constants.titleLabelLeadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: disclosureLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: disclosureIconImageView.leadingAnchor)
        ])
    }
    
    func configure(with menuCellModel: MenuCellModel) {
        iconImageView.image = UIImage(named: menuCellModel.iconName)
        titleLabel.text = menuCellModel.title
        disclosureIconImageView.image = UIImage(systemName: menuCellModel.disclosureIconName ?? "")
        disclosureLabel.text = menuCellModel.disclosureImageName
        disclosure = menuCellModel.disclosure
    }
}
