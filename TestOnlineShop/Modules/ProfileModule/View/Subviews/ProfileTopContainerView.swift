//
//  ProfileTopContainerView.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import UIKit

protocol ProfileTopContainerViewActionsDelegate: AnyObject {
    func changePhotoButtonTapped()
    func uploadItemButtonTapped()
}

final class ProfileTopContainerView: ParentContainerView {
    
    weak var actionsDelegate: ProfileTopContainerViewActionsDelegate?
    
    private enum Constants {
        static let userPhotoWidthHeight: CGFloat = 60
        static let uploadItemButtonLeading: CGFloat = 10
        static let uploadItemButtonTrailing: CGFloat = -10
        static let uploadItemButtonHeight: CGFloat = 40
        static let uploadItemButtonNameTitleLabelInset: CGFloat = 20
    }
    
    private let nameTitleLabel = CustomLabel(.profileName)
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.userPhotoWidthHeight / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
        
    private lazy var changePhotoButton = CustomButton(.changePhotoButton,
                                                 action: UIAction { [weak self] _ in
        self?.actionsDelegate?.changePhotoButtonTapped()
    })
    
    private let uploadItemButton = CustomButton(.uploadItem,
                                                action: UIAction { _ in
        print(#function)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buttonTapped(_ sender: UIButton) -> UIAction {
        UIAction { [weak self] _ in
            switch sender {
            case self?.changePhotoButton:
                self?.actionsDelegate?.changePhotoButtonTapped()
            case self?.uploadItemButton:
                self?.actionsDelegate?.uploadItemButtonTapped()
            default:
                break
            }
        }
    }
    
    func configure(with name: String, image: UIImage?) {
        nameTitleLabel.text = name
        userPhotoImageView.image = image
    }
    
    private func setupUI() {
        
        let subviews = [
            userPhotoImageView,
            changePhotoButton,
            nameTitleLabel,
            uploadItemButton
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
            changePhotoButton.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor),
            changePhotoButton.centerXAnchor.constraint(equalTo: userPhotoImageView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameTitleLabel.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor),
            nameTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            uploadItemButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: Constants.uploadItemButtonLeading),
            uploadItemButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: Constants.uploadItemButtonTrailing),
            uploadItemButton.heightAnchor.constraint(equalToConstant: Constants.uploadItemButtonHeight),
            uploadItemButton.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor,
                                                  constant: Constants.uploadItemButtonNameTitleLabelInset),
            uploadItemButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
