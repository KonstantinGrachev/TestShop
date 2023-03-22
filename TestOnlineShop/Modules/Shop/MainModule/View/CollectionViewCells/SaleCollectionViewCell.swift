//
//  SaleCollectionViewCell.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 16.03.2023.
//

import UIKit

final class SaleCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "SaleCollectionViewCell"
    
    private enum Constants {
        static let contentViewCornerRadius: CGFloat = 15
        static let plusButtonSize: CGFloat = 35
        static let plusButtonTrailingBottom: CGFloat = -5
        static let leading: CGFloat = 7
        static let priceLabelBottom: CGFloat = -8
        static let nameLabelInsetBetweenBackgroundCategoryView: CGFloat = 5
        static let categoryNameLabelLeadingInsetBetweenTextAndBackground: CGFloat = 5
        static let categoryNameLabelTrailingInsetBetweenTextAndBackground: CGFloat = -5
        static let backgroundCategoryViewBottom: CGFloat = -80
        static let backgroundCategoryViewHeight: CGFloat = 17
        static let backgroundCategoryViewCornerRadius: CGFloat = 5
        static let sellerImageViewHeightWidth: CGFloat = 24
        static let heartButtonHeightWidth: CGFloat = 28
        static let heartButtonTrailing: CGFloat = -5
        static let sellerImageViewTop: CGFloat = 8
        static let sellerImageViewLeading: CGFloat = 8
        static let backgroundSaleOffViewTrailing: CGFloat = -8
        static let backgroundSaleOffViewTop: CGFloat = 8
        static let backgroundSaleOffViewHeight: CGFloat = 18
        static let saleOffLabelLeading: CGFloat = 5
        static let saleOffLabelTrailing: CGFloat = -5
    }
    
    private let backgroundCategoryView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.buttonSecondaryBackgroundColor
        view.layer.cornerRadius = Constants.backgroundCategoryViewCornerRadius
        return view
    }()
    
    private let sellerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ThemeImages.seller)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = ThemeColor.buttonSecondaryBackgroundColor.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = Constants.sellerImageViewHeightWidth / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let saleOffLabel = CustomLabel(.saleOffIntoCell)
    private let nameLabel = CustomLabel(.nameIntoSaleCell)
    private let priceLabel = CustomLabel(.priceIntoSaleCell)
    private let categoryNameLabel = CustomLabel(.categoryIntoSaleCell)
    
    private let backgroundSaleOffView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.salesMarkColor
        view.layer.cornerRadius = 8
        return view
    }()
    
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
    
    private let heartButton = CustomButton(.heartIntoSaleCell, action: UIAction { _ in
        print(#function)
    })
    
    private let plusButton = CustomButton(.plusIntoSaleCell, action: UIAction { _ in
        print(#function)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with saleItem: SaleItem) {
        imageView.image = saleItem.image
        categoryNameLabel.text = saleItem.category
        nameLabel.text = saleItem.name
        priceLabel.text = "$ \(saleItem.price.formattedWithSeparator)"
        saleOffLabel.text = "\(saleItem.discount)% off"
    }
    
    private func setupUI() {
        
        layer.cornerRadius = Constants.contentViewCornerRadius
        clipsToBounds = true
        
        [imageView,
         fogBackgroundImageView,
         sellerImageView,
         backgroundSaleOffView,
         saleOffLabel,
         nameLabel,
         plusButton,
         heartButton,
         backgroundCategoryView,
         categoryNameLabel,
         priceLabel].forEach {
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
            heartButton.heightAnchor.constraint(equalToConstant: Constants.heartButtonHeightWidth),
            heartButton.widthAnchor.constraint(equalToConstant: Constants.heartButtonHeightWidth),
            heartButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: Constants.heartButtonTrailing),
            heartButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor)
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
            sellerImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.sellerImageViewTop),
            sellerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sellerImageViewLeading),
            sellerImageView.heightAnchor.constraint(equalToConstant: Constants.sellerImageViewHeightWidth),
            sellerImageView.widthAnchor.constraint(equalToConstant: Constants.sellerImageViewHeightWidth)
        ])
        
        NSLayoutConstraint.activate([
            backgroundSaleOffView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.backgroundSaleOffViewTrailing),
            backgroundSaleOffView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.backgroundSaleOffViewTop),
            backgroundSaleOffView.heightAnchor.constraint(equalToConstant: Constants.backgroundSaleOffViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            saleOffLabel.leadingAnchor.constraint(equalTo: backgroundSaleOffView.leadingAnchor,
                                                  constant: Constants.saleOffLabelLeading),
            saleOffLabel.centerYAnchor.constraint(equalTo: backgroundSaleOffView.centerYAnchor),
            saleOffLabel.trailingAnchor.constraint(equalTo: backgroundSaleOffView.trailingAnchor,
                                                   constant: Constants.saleOffLabelTrailing)
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
            priceLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: backgroundCategoryView.leadingAnchor)
        ])
    }
}
