//
//  SmallPhotoCollectionViewCell.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

final class SmallPhotoCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "SmallPhotoCollectionViewCell"
    
    var isSelectedPhoto = false {
        didSet {
            if isSelectedPhoto {
                self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.dropВDetailsImageShadow(isSelected: self.isSelectedPhoto)
            } else {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.dropВDetailsImageShadow(isSelected: self.isSelectedPhoto)
            }
        }
    }
    
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
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
        isSelectedPhoto = photoItem.isSelectedPhoto
        
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        
        let subviews = [
            photoImageView,
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
