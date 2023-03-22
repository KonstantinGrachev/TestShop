//
//  CellFactory.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 17.03.2023.
//

import UIKit

final class MainCellsFactory {
    private let cells = [
        CategoryCollectionViewCell.cellID: CategoryCollectionViewCell.self,
        LatestCollectionViewCell.cellID: LatestCollectionViewCell.self,
        BrandsCollectionViewCell.cellID: BrandsCollectionViewCell.self,
        SaleCollectionViewCell.cellID: SaleCollectionViewCell.self,
    ]
    
    private var collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func registerCollectionViewCellsTypes() {
        cells.forEach { collectionView.register($1, forCellWithReuseIdentifier: $0) }
    }
    
    func createCell(section: MainListSection, indexPath: IndexPath) -> UICollectionViewCell {
        switch section {
        case .categories(let categories):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.cellID,
                                                                for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: categories[indexPath.row])
            return cell
            
        case .latest(let latest):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCollectionViewCell.cellID,
                                                                for: indexPath) as? LatestCollectionViewCell,
                  let latest = latest?[indexPath.row] else {
                return UICollectionViewCell()
            }
            cell.configure(with: latest)
            return cell
            
        case .sales(let sales):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionViewCell.cellID,
                                                                for: indexPath) as? SaleCollectionViewCell,
                  let flashSale = sales?[indexPath.row] else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: flashSale)
            return cell
            
        case .brands(let brands):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandsCollectionViewCell.cellID,
                                                                for: indexPath) as? BrandsCollectionViewCell,
                  let brands = brands?[indexPath.row] else {
                return UICollectionViewCell()
            }
            cell.configure(with: brands)
            return cell
        }
    }
}
