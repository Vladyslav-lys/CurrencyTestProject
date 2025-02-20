//
//  RateCVC.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 16.02.2025.
//

import UIKit
import Services

final class RateCVC: UICollectionViewCell {
    // MARK: - Constants
    private enum PrivateConstants {
        static let imageSize: CGFloat = 16
    }
    
    // MARK: - Views
    private var currenciesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private var quoteLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private var starImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var separatorView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupCurrenciesLabel()
        setupQuoteLabel()
        setupSeparatorView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    func configure(rate: Rate) {
        currenciesLabel.text = "\(rate.baseCurrency) - \(rate.quoteCurrency)"
        quoteLabel.text = "\(String(format: "%.3f", rate.quote.doubleValue))"
        starImageView.image = rate.isFavorite == true ? R.image.icFavorite() : R.image.icNotFavorite()
    }
    
    // MARK: - Setup
    private func setupCurrenciesLabel() {
        addSubview(currenciesLabel)
        
        NSLayoutConstraint.activate([
            currenciesLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 8),
            currenciesLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor)
        ])
    }
    
    private func setupQuoteLabel() {
        addSubview(quoteLabel)
        
        NSLayoutConstraint.activate([
            quoteLabel.leadingAnchor.constraint(equalTo: currenciesLabel.trailingAnchor, constant: 16),
            quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            quoteLabel.centerYAnchor.constraint(equalTo: currenciesLabel.centerYAnchor)
        ])
    }
    
    private func setupImageView() {
        addSubview(starImageView)
        
        NSLayoutConstraint.activate([
            starImageView.widthAnchor.constraint(equalToConstant: PrivateConstants.imageSize),
            starImageView.heightAnchor.constraint(equalTo: starImageView.widthAnchor, multiplier: 1),
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            starImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupSeparatorView() {
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero),
        ])
    }
}
