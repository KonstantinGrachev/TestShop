//
//  MainCompositionLayout.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 17.03.2023.
//

import UIKit

final class MainCompositionLayout {
    
    func createLayout(with sections: [MainListSection]) -> UICollectionViewCompositionalLayout? {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            
            let section = sections[sectionIndex]
            
            switch section {
            case .categories:
                return self.createCategoriesSection()
            case .latest:
                return self.createLatestSection()
            case .sales:
                return self.createSalesSection()
            case .brands:
                return self.createBrandsSection()
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior:UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
    
    private func createCategoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(60),
                                              heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup
            .horizontal(layoutSize: groupSize,
                        subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 5,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    private func createLatestSection() -> NSCollectionLayoutSection {
        let itemAndGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(114),
                                              heightDimension: .absolute(149))
        let item = NSCollectionLayoutItem(layoutSize: itemAndGroupSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemAndGroupSize,
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [setSupplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    private func createBrandsSection() -> NSCollectionLayoutSection {
        let itemAndGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(114),
                                              heightDimension: .absolute(149))
        let item = NSCollectionLayoutItem(layoutSize: itemAndGroupSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemAndGroupSize,
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [setSupplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    private func createSalesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.465),
                                              heightDimension: .absolute(221))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [setSupplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    private func setSupplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}
