//
//  ColorCollectionViewCell.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "ColorCollectionViewCell"
    
    var isSelectedColor: Bool = false {
        didSet {
            if isSelectedColor {
                layer.borderColor = UIColor.gray.cgColor
                layer.borderWidth = 2
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(colorItem: ColorItem?) {
        guard let colorItem = colorItem else { return }
        backgroundColor = colorItem.color
        isSelectedColor = colorItem.isSelectedColor
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
    }
}
