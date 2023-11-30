//
//  AirQualityDetailsViewController.swift
//  EcoTracker
//
//  Created by Ani's Mac on 30.11.23.
//

import UIKit

final class AirQualityDetailsViewController: UIViewController {
    // MARK: - Properties
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityTitleLabel, airQualityIndex, airQualityIndexDescription])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.backgroundColor = UIColor.accentColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        return stackView
    }()
    
    private let cityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Georgia"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        return label
    }()
    
    private let airQualityIndex: UILabel = {
        let label = UILabel()
        label.text = "14"
        label.textColor = UIColor(red: 96/255.0, green: 217/255.0, blue: 37/255.0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48, weight: .medium)
        return label
    }()
    
    private let airQualityIndexDescription: UILabel = {
        let label = UILabel()
        label.text = "Air quality is great, no significant health risk."
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundColor
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        addMainSubview()
        setupMainViewConstraints()
    }
    
    private func addMainSubview() {
        view.addSubview(mainStackView)
    }

    private func setupMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


