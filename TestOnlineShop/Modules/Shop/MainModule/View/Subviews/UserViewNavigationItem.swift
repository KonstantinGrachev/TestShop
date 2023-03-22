//
//  UserViewNavigationItem.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import UIKit

final class UserViewNavigationItem: ParentContainerView {
    private enum Constants {
        static let userPhotoWidthHeight: CGFloat = 30
        static let chevronWidthHeight: CGFloat = 6
        static let selfHeightWidth: CGFloat = 46
        static let locationButtonTopToUserPhotoImageView: CGFloat = 5
    }
    

    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UserDefaults.standard.value(UserModel.self,
                                                forKey: UserDefaultsKeys.user.rawValue)?.image?.toImage()
        imageView.image = image
        imageView.layer.cornerRadius = Constants.userPhotoWidthHeight / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var locationButton: CustomButton = {
        let button = CustomButton(.location, action: buttonTapped())
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buttonTapped() -> UIAction {
        UIAction { _ in
            print(#function)
        }
    }
    
    private func setupUI() {
                
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.selfHeightWidth),
            widthAnchor.constraint(equalToConstant:  Constants.selfHeightWidth)
        ])
        
        let subviews = [
            userPhotoImageView,
            locationButton
        ]
        
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: topAnchor),
            userPhotoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: Constants.userPhotoWidthHeight),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: Constants.userPhotoWidthHeight)
        ])
        
        NSLayoutConstraint.activate([
            locationButton.centerXAnchor.constraint(equalTo: userPhotoImageView.centerXAnchor),
            locationButton.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: Constants.locationButtonTopToUserPhotoImageView),
            locationButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
