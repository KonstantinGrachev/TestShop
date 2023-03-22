//
//  LargePhotoCollectionViewCell.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

final class LargePhotoCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "LargePhotoCollectionViewCell"
    
    private enum Constants {
        static let likeShareContainerViewHeight: CGFloat = 95
        static let likeShareContainerViewWidth: CGFloat = 42
        static let likeShareContainerViewcenterYoffset: CGFloat = 40
        static let cornerRadius: CGFloat = 10
    }

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let likeShareContainerView = LikeShareContainerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(photoItem: PhotoItem?) {
        guard let photoItem = photoItem else { return }
        photoImageView.image = photoItem.photo
        isSelected = photoItem.isSelectedPhoto
    }
    
    private func setupUI() {
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        
        let subviews = [
            photoImageView,
            likeShareContainerView
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            likeShareContainerView.heightAnchor.constraint(equalToConstant: Constants.likeShareContainerViewHeight),
            likeShareContainerView.widthAnchor.constraint(equalToConstant: Constants.likeShareContainerViewWidth),
            likeShareContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            likeShareContainerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.likeShareContainerViewcenterYoffset)
        ])
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: likeShareContainerView.centerXAnchor)
        ])
    }
}
