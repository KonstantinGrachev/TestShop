//
//  LatestCollectionViewCell.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 16.03.2023.
//

import UIKit

final class LatestCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "LatestCollectionViewCell"
 
    private enum Constants {
        static let contentViewCornerRadius: CGFloat = 15
        static let plusButtonSize: CGFloat = 20
        static let plusButtonTrailingBottom: CGFloat = -5
        static let leading: CGFloat = 7
        static let priceLabelBottom: CGFloat = -8
        static let nameLabelInsetBetweenBackgroundCategoryView: CGFloat = 5
        static let categoryNameLabelLeadingInsetBetweenTextAndBackground: CGFloat = 5
        static let categoryNameLabelTrailingInsetBetweenTextAndBackground: CGFloat = -5
        static let backgroundCategoryViewBottom: CGFloat = -45
        static let backgroundCategoryViewHeight: CGFloat = 12
        static let backgroundCategoryViewCornerRadius: CGFloat = 5
    }
    
    private let plusButton = CustomButton(.plusIntoCell, action: UIAction { _ in
        print(#function)
    })
    
    private let backgroundCategoryView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.buttonSecondaryBackgroundColor
        view.layer.cornerRadius = Constants.backgroundCategoryViewCornerRadius
        return view
    }()
    
    private let categoryNameLabel = CustomLabel(.categoryIntoLatestCell)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let fogBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundFog")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel = CustomLabel(.nameIntoLatestCell)
    
    private let priceLabel = CustomLabel(.priceIntoLatestCell)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with latest: LatestItem) {
        imageView.image = latest.image
        categoryNameLabel.text = latest.category
        nameLabel.text = latest.name
        priceLabel.text = "$ \(latest.price.formattedWithSeparator)"
    }
    
    private func setupUI() {
        
        layer.cornerRadius = Constants.contentViewCornerRadius
        clipsToBounds = true
        
        [imageView, fogBackgroundImageView, nameLabel, plusButton, backgroundCategoryView, categoryNameLabel, priceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            plusButton.heightAnchor.constraint(equalToConstant: Constants.plusButtonSize),
            plusButton.widthAnchor.constraint(equalToConstant: Constants.plusButtonSize),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.plusButtonTrailingBottom),
            plusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.plusButtonTrailingBottom)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fogBackgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            fogBackgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            fogBackgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fogBackgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backgroundCategoryView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leading),
            backgroundCategoryView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.backgroundCategoryViewBottom),
            backgroundCategoryView.heightAnchor.constraint(equalToConstant: Constants.backgroundCategoryViewHeight),
        ])
        
        NSLayoutConstraint.activate([
            categoryNameLabel.leadingAnchor.constraint(equalTo: backgroundCategoryView.leadingAnchor,
                                                       constant: Constants.categoryNameLabelLeadingInsetBetweenTextAndBackground),
            categoryNameLabel.centerYAnchor.constraint(equalTo: backgroundCategoryView.centerYAnchor),
            categoryNameLabel.trailingAnchor.constraint(equalTo: backgroundCategoryView.trailingAnchor,
                                                        constant: Constants.categoryNameLabelTrailingInsetBetweenTextAndBackground)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backgroundCategoryView.bottomAnchor,
                                           constant: Constants.nameLabelInsetBetweenBackgroundCategoryView),
            nameLabel.leadingAnchor.constraint(equalTo: backgroundCategoryView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                               constant: Constants.priceLabelBottom),
            priceLabel.leadingAnchor.constraint(equalTo: backgroundCategoryView.leadingAnchor)
        ])
    }
}
