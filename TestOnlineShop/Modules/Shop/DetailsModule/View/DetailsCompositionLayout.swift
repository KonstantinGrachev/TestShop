//
//  DetailsCompositionLayout.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 18.03.2023.
//

import UIKit

final class DetailsCompositionLayout {

    private enum Constants {
        static let contentInsets: NSDirectionalEdgeInsets = .init(top: 10,
                                                                  leading: 40,
                                                                  bottom: 10,
                                                                  trailing: 40)
        
        static let contentInsetsSmallSection: NSDirectionalEdgeInsets = .init(top: 10,
                                                                  leading: 100,
                                                                  bottom: 10,
                                                                  trailing: 100)
        
        static let interGroupSpacings: CGFloat = 15
        static let heightLargeSection: CGFloat = 200
        static let smallSectionGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(65),
                                                                  heightDimension: .absolute(37))
        static let heightInfoSection: CGFloat = 110
        static let colorGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(32),
                                                      heightDimension: .absolute(26))
        static let heightSupplementaryView: CGFloat = 20
    }
    
    func createLayout(with sections: [DetailsListSection]) -> UICollectionViewCompositionalLayout? {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            
            let section = sections[sectionIndex]

            switch section {
            case .large:
                return self.createLargeSection()
            case .small:
                return self.createSmallSection()
            case .info:
                return self.createInfoSection()
            case .color:
                return self.createColorSection()
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

    private func createLargeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(Constants.heightLargeSection))
        let group = NSCollectionLayoutGroup
            .horizontal(layoutSize: groupSize,
                        subitems: [item])

        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: Constants.interGroupSpacings,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = Constants.contentInsets

        return section
    }
    
    private func createSmallSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let groupSize = Constants.smallSectionGroupSize
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup
            .horizontal(layoutSize: groupSize,
                        subitems: [item])

        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: Constants.interGroupSpacings,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = Constants.contentInsetsSmallSection
        
        return section
    }

    private func createInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(Constants.heightInfoSection))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: Constants.interGroupSpacings,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = Constants.contentInsets
        
        return section
    }

    private func createColorSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = Constants.colorGroupSize
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: Constants.interGroupSpacings,
                                          supplementaryItems: [setSupplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = Constants.contentInsets
        
        return section
    }
    
    private func setSupplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1.05),
                                heightDimension: .estimated(Constants.heightSupplementaryView)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}
