//
//  DetailsCellFactory.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

final class DetailsCellsFactory {
    let cells = [
        LargePhotoCollectionViewCell.cellID: LargePhotoCollectionViewCell.self,
        SmallPhotoCollectionViewCell.cellID: SmallPhotoCollectionViewCell.self,
        DetailsInfoCollectionViewCell.cellID: DetailsInfoCollectionViewCell.self,
        ColorCollectionViewCell.cellID: ColorCollectionViewCell.self,
    ]
    
    var collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func registerCellsTypes() {
        cells.forEach { collectionView.register($1, forCellWithReuseIdentifier: $0) }
    }
    
    func createCell(section: DetailsListSection, indexPath: IndexPath) -> UICollectionViewCell {
        switch section {
        case .large(let large):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargePhotoCollectionViewCell.cellID, for: indexPath) as? LargePhotoCollectionViewCell else { return UICollectionViewCell() }
            let photoItem = large?[indexPath.row]
            cell.configure(photoItem: photoItem)
            return cell
        case .small(let small):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallPhotoCollectionViewCell.cellID, for: indexPath) as? SmallPhotoCollectionViewCell else { return UICollectionViewCell() }
            let photoItem = small?[indexPath.row]
            cell.configure(photoItem: photoItem)
            return cell
        case .info(let info):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsInfoCollectionViewCell.cellID, for: indexPath) as? DetailsInfoCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(detailsInfo: info)
            return cell
        case .color(let color):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.cellID, for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(colorItem: color?[indexPath.row])
            return cell
        }
    }
}
