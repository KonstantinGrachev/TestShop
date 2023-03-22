//
//  CategoryCollectionViewCell.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 16.03.2023.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "CategoryCollectionViewCell"
    
    private enum Constants {
        static let roundedViewHeightWidth: CGFloat = 40
        static let imageViewHeightWidth: CGFloat = 20
    }
    
    let roundedBackgroundView = CustomBackgroundView(.roundedIntoCategoryCell, forRounded: Constants.roundedViewHeightWidth)
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel = CustomLabel(.categoryLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: ProductCategoryItem) {
        titleLabel.text = category.title
        imageView.image = UIImage(named: category.imageName)
    }
    
    private func setupUI() {
        [roundedBackgroundView, imageView, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            roundedBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundedBackgroundView.heightAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidth),
            roundedBackgroundView.widthAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidth)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: roundedBackgroundView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: roundedBackgroundView.centerYAnchor),
            roundedBackgroundView.heightAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidth),
            roundedBackgroundView.widthAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidth)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
