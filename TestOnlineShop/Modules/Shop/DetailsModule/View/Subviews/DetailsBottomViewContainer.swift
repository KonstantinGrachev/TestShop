//
//  DetailsBottomViewContainer.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 17.03.2023.
//

import UIKit

final class DetailsBottomViewContainer: ParentContainerView {
    
    private let backgroundViewPlusButton = CustomBackgroundView(.plusMinusButtonInDetails)
    private let backgroundViewMinusButton = CustomBackgroundView(.plusMinusButtonInDetails)
    private let backgroundViewAddToCartButton = CustomBackgroundView(.addToCartButtonInDetails)
    
    private let quantityLabel = CustomLabel(.quantityTitleLabel)
    private let totalLabel = CustomLabel(.detailsTotalLabel)
    
    private enum Constants {
        static let plusMinusHStackViewSpacing: CGFloat = -10
        static let quantityAndPlusMinusVStackViewSpacing: CGFloat = 10
        static let priceAndButtonHStackViewSpacing: CGFloat = -20
        static let cornerRadius: CGFloat = 30
        
        static let generalHStackViewHeight: CGFloat = 50
        static let generalHStackViewTrailing: CGFloat = -13
        static let generalHStackViewLeading: CGFloat = 13
        static let generalHStackViewCenterYOffset: CGFloat = -5
        
        static let priceAndButtonHStackViewLeading: CGFloat = 30
        static let priceAndButtonHStackViewTrailing: CGFloat = -30

        static let plusMinusHStackViewWidth: CGFloat = 90
        static let plusMinusHStackViewHeight: CGFloat = 22
        static let quantityLabelHeight: CGFloat = 20
    }
    
    var viewModel: DetailsViewModelProtocol?
    var quantity = 1
    var price = Int()
    var total = Int()
    
    private lazy var plusButton = CustomButton(.detailsPlusButton, action: UIAction { [weak self] _ in
        guard let self = self else { return }
        self.quantity += 1
        self.total = self.price * self.quantity
        self.quantityLabel.text = "\(LocalizedStrings.quantityTitleLabel): \(self.quantity)"
        self.totalLabel.text =  "$ \(self.total)"
    })
    
    private lazy var minusButton = CustomButton(.detailsMinusButton, action: UIAction { [weak self] _ in
        guard let self = self else { return }
        if self.quantity > 1 {
            self.quantity -= 1
            self.total = self.price * self.quantity
            self.quantityLabel.text = "\(LocalizedStrings.quantityTitleLabel): \(self.quantity)"
            self.totalLabel.text =  "$ \(self.total)"
        }
    })
    
    private lazy var addToCartButton = CustomButton(.addToCartButton, action: UIAction { [weak self] _ in
        self?.viewModel?.moveToCart()
    })
    
    private lazy var plusMinusHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        minusButton, UIView(), plusButton
        ])
        stackView.spacing = Constants.plusMinusHStackViewSpacing
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var quantityAndPlusMinusVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        quantityLabel, plusMinusHStackView
        ])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = Constants.quantityAndPlusMinusVStackViewSpacing
        return stackView
    }()
    
    private lazy var priceAndButtonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        totalLabel,
        addToCartButton
        ])
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.priceAndButtonHStackViewSpacing
        return stackView
    }()
    
    private lazy var generalHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            quantityAndPlusMinusVStackView,
            UIView(),
            backgroundViewAddToCartButton
            ])
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: DetailsViewModelProtocol?) {
        
        guard let viewModel = viewModel, let price = viewModel.info?.price else { return }
        self.price = price
        self.viewModel = viewModel
        totalLabel.text = "$ \(price)"
        quantityLabel.text = "\(LocalizedStrings.quantityTitleLabel): \(quantity)"
    }
    
    private func setupUI() {
        backgroundColor = ThemeColor.cartDarkBackgroundColor
        layer.cornerRadius = Constants.cornerRadius
        
        let subviews = [
            generalHStackView,
            priceAndButtonHStackView
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            generalHStackView.heightAnchor.constraint(equalToConstant: Constants.generalHStackViewHeight),
            generalHStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                        constant: Constants.generalHStackViewTrailing),
            generalHStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                       constant: Constants.generalHStackViewLeading),
            generalHStackView.centerYAnchor.constraint(equalTo: centerYAnchor,
                                                       constant: Constants.generalHStackViewCenterYOffset)
        ])
        
        NSLayoutConstraint.activate([
            priceAndButtonHStackView.leadingAnchor.constraint(equalTo: backgroundViewAddToCartButton.leadingAnchor, constant: Constants.priceAndButtonHStackViewLeading),
            priceAndButtonHStackView.trailingAnchor.constraint(equalTo: backgroundViewAddToCartButton.trailingAnchor, constant:  Constants.priceAndButtonHStackViewTrailing),
            priceAndButtonHStackView.centerYAnchor.constraint(equalTo: backgroundViewAddToCartButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            plusMinusHStackView.widthAnchor.constraint(equalToConstant: Constants.plusMinusHStackViewWidth),
            plusMinusHStackView.heightAnchor.constraint(equalToConstant: Constants.plusMinusHStackViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            quantityLabel.heightAnchor.constraint(equalToConstant: Constants.quantityLabelHeight)
        ])
    }
}
