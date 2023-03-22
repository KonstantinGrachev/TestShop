//
//  LikeShareContainerView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

final class LikeShareContainerView: ParentContainerView {
    
    private enum Constans {
        static let vStackViewTopInset: CGFloat = 3
        static let vStackViewBottomInset: CGFloat = -3
        static let vStackViewLeadingInset: CGFloat = 3
        static let vStackViewTrailingInset: CGFloat = -3
        static let separatorViewHeight: CGFloat = 1
        static let cornerRadius: CGFloat = 10

    }
    private var isLiked = false {
        didSet {
            if self.isLiked {
                self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    private lazy var likeButton = CustomButton(.detailsLikeButton, action: UIAction { [weak self] _ in
        guard let self = self else { return }
        self.isLiked.toggle()
    })
    
    
    private let shareButton = CustomButton(.detailsShareButton, action: UIAction { _ in
        print(#function)
    })

        
    private let separatorView = CustomBackgroundView(.detailsLargePhotoSeparatorView)
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            likeButton,
            UIView(),
            shareButton
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
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
    
    private func setupUI() {
        backgroundColor = ThemeColor.buttonSecondaryBackgroundColor
        
        layer.cornerRadius = Constans.cornerRadius

        let subviews = [
        vStackView,
        separatorView
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constans.vStackViewTopInset),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constans.vStackViewLeadingInset),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constans.vStackViewTrailingInset),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constans.vStackViewBottomInset)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: Constans.separatorViewHeight),
            separatorView.widthAnchor.constraint(equalTo: vStackView.widthAnchor, multiplier: 0.5),
            separatorView.centerXAnchor.constraint(equalTo: vStackView.centerXAnchor),
            separatorView.centerYAnchor.constraint(equalTo: vStackView.centerYAnchor)
        ])
    }
}
