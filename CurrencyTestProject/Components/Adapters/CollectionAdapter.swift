//
//  CollectionAdapter.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 16.02.2025.
//

import UIKit

protocol CollectionAdapterDelegate: AnyObject {
    func collectionAdapterDidSelectItem<Section: Hashable, Item: Hashable>(_ adapter: CollectionAdapter<Section, Item>, item: Item)
}

final class CollectionAdapter<Section: Hashable, Item: Hashable>: NSObject, UICollectionViewDelegate {
    typealias Content = (section: Section, items: [Item])
    
    // MARK: - Private propeties
    private var collectionView: UICollectionView
    
    // MARK: - Public propeties
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>
    weak var delegate: CollectionAdapterDelegate?
    
    // MARK: - Initialize
    init(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath, Item) -> UICollectionViewCell) {
        self.collectionView = collectionView
        self.dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: cellProvider)
        super.init()
        self.collectionView.delegate = self
    }
    
    // MARK: - Helpers
    func updateData(content: [Content], animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        content.forEach {
            snapshot.appendSections([$0.section])
            snapshot.appendItems($0.items, toSection: $0.section)
        }
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        delegate?.collectionAdapterDidSelectItem(self, item: item)
    }
}
