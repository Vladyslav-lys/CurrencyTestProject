//
//  UICollectionView+Helpers.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 16.02.2025.
//

import UIKit

extension UICollectionView {
    func registerNib<T>(for cellClass: T.Type) where T: UICollectionViewCell {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCollectionViewCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T else {
            fatalError("Cannot find cell \(String(describing: cellClass))")
        }
        return cell
    }
    
    func makeCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath, builder: (T) -> Void) -> T {
        with(dequeueReusableCollectionViewCell(cellClass: cellClass, for: indexPath)) {
            builder($0)
        }
    }
    
    func register(_ types: UICollectionViewCell.Type...) {
        types.forEach(registerNib)
    }
}
