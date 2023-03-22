//
//  PhotoItem.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

final class PhotoItem {
    let photo: UIImage
    var isSelectedPhoto: Bool
    
    init(photo: UIImage, isSelectedPhoto: Bool) {
        self.photo = photo
        self.isSelectedPhoto = isSelectedPhoto
    }
}
