//
//  RateCVC.swift
//  CurrencyTestProject
//
//  Created by Vladyslav Lysenko on 16.02.2025.
//

import UIKit
import Services

final class RateCVC: UICollectionViewCell {
    // MARK: - Properties
    private var rate: Rate?
    
    // MARK: - Views
    private var ratesLabel: UILabel = {
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
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRatesLabel()
        setupQuoteLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    func configure(rate: Rate) {
        self.rate = rate
        ratesLabel.text = "\(rate.baseCurrency) - \(rate.quoteCurrency)"
        quoteLabel.text = "\(String(format: "%.3f", rate.quote.doubleValue))"
    }
    
    // MARK: - Setup
    private func setupRatesLabel() {
        addSubview(ratesLabel)
        
        NSLayoutConstraint.activate([
            ratesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ratesLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupQuoteLabel() {
        addSubview(quoteLabel)
        
        NSLayoutConstraint.activate([
            quoteLabel.leadingAnchor.constraint(equalTo: ratesLabel.trailingAnchor, constant: 16),
            quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            quoteLabel.centerYAnchor.constraint(equalTo: ratesLabel.centerYAnchor)
        ])
    }
}
