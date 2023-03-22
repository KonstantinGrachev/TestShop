//
//  RateReviewContainerView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

final class RateReviewContainerView: ParentContainerView {
    
    private let rateImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: ThemeImages.rateStar)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let rateLabel = CustomLabel(.detailsRateIntoDetails)
    private let reviewsLabel = CustomLabel(.detailsReviewsIntoLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(rate: Double, reviews: Int) {
        rateLabel.text = "\(rate)"
        reviewsLabel.text = "(\(reviews) reviews)"
    }
    
    private func setupUI() {
        let subviews = [
        rateImageView,
        rateLabel,
        reviewsLabel
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            rateImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rateImageView.topAnchor.constraint(equalTo: topAnchor),
            rateImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rateLabel.leadingAnchor.constraint(equalTo: rateImageView.trailingAnchor, constant: 5),
            rateLabel.topAnchor.constraint(equalTo: topAnchor),
            rateLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            reviewsLabel.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor, constant: 5),
            reviewsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            reviewsLabel.topAnchor.constraint(equalTo: topAnchor),
            reviewsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
