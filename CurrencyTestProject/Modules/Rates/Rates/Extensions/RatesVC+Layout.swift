//
//  RatesVC+Layout.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 16.02.2025.
//

import UIKit

extension RatesVC {
    // MARK: - Constants
    private enum C {
        static let ratesItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48))
        static let ratesSectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(48))
    }
    
    // MARK: - Public Methods
    func makeLayout(dataSource: UICollectionViewDiffableDataSource<Section, Item>) -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { [weak self, weak dataSource] index, _ in
            switch dataSource?.snapshot().sectionIdentifiers[index] {
            case .rates: self?.makeRatesSection()
            default: nil
            }
        })
    }
    
    // MARK: - Private Methods
    private func makeRatesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: C.ratesItemSize)
        let section = NSCollectionLayoutSection(group: .vertical(layoutSize: C.ratesSectionSize, subitems: [item]))
        return section
    }
}
