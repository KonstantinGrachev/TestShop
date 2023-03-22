//
//  DetailsInfoCollectioViewCell.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

final class DetailsInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "DetailsInfoCollectioViewCell"
    
    private let nameLabel = CustomLabel(.detailsNameIntoCell)
    private let priceLabel = CustomLabel(.detailsPriceIntoCell)
    private let descriptionLabel = CustomLabel(.detailsDescriptionIntoCell)
    private let rateReviewsContainerView = RateReviewContainerView()
    
    private lazy var topHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            priceLabel
        ])
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var midHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            descriptionLabel,
            UIView()
        ])
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var downHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            rateReviewsContainerView,
            UIView()
        ])
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topHStackView,
            midHStackView,
            downHStackView
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
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
    
    func configure(detailsInfo: DetailsInfo?) {
        guard let detailsInfo = detailsInfo else { return }
        rateReviewsContainerView.configure(rate: detailsInfo.rating,
                                           reviews: detailsInfo.numberOfReviews)
        nameLabel.text = detailsInfo.name
        priceLabel.text = "$ \(detailsInfo.price.formattedWithSeparator)"
        descriptionLabel.text = detailsInfo.description
        
    }
    
    private func setupUI() {
        let subviews = [
            vStackView
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
