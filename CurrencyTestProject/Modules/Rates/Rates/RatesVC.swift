//
//  RatesVC.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 12.02.2025.
//

import UIKit
import Services

extension RatesVC: Makeable {
    static func make() -> RatesVC { RatesVC() }
}

final class RatesVC: BaseVC, ViewModelContainer {
    enum Section: Int {
        case rates
    }

    enum Item: Equatable, Hashable {
        case rate(rate: Rate)
    }
    
    // MARK: - View model
    var viewModel: RatesVM?
    
    // MARK: - Adapter
    private var adapter: CollectionAdapter<Section, Item>?
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RateCVC.self)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func bind() {
        super.bind()
        guard let viewModel else { return }
        setupViewModel()
        
        viewModel.$latestRates
            .sink { [weak self] rates in
                self?.adapter?.updateData(content: [(section: .rates, items: rates.map(Item.rate))])
            }
            .store(in: &subscriptions)
    }
    
    override func setupVC() {
        super.setupVC()
        setupNavigationBarTitle()
        setupCollectionView()
        setupAdapter()
    }
    
    // MARK: - Setup
    private func setupNavigationBarTitle() {
        navigationItem.title = R.string.localizable.exchangeRates()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero)
        ])
    }
    
    private func setupAdapter() {
        adapter = CollectionAdapter(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .rate(let rate):
                collectionView.makeCell(RateCVC.self, for: indexPath) {
                    $0.configure(rate: rate)
                }
            }
        }
        adapter?.delegate = self
        adapter.flatMap { adapter in
            collectionView.collectionViewLayout = makeLayout(dataSource: adapter.dataSource)
        }
    }
}

// MARK: - CollectionAdapterDelegate
extension RatesVC: CollectionAdapterDelegate {
    func collectionAdapterDidSelectItem<Section, Item>(_ adapter: CollectionAdapter<Section, Item>, item: Item) {
        guard let ratesItem = item as? RatesVC.Item else { return }
        switch ratesItem {
        case .rate(let rate):
            var rate = rate
            rate.isFavorite = rate.isFavorite.flatMap { !$0 } ?? true
            viewModel?.updateRate(rate: rate)
            let newItem = RatesVC.Item.rate(rate: rate) as? Item
            DispatchQueue.main.async {
                var snapshot = adapter.dataSource.snapshot()
                newItem.flatMap { snapshot.update(item, to: $0) }
                adapter.dataSource.apply(snapshot)
            }
        }
    }
}
