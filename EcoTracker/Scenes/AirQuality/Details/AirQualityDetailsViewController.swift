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
        label.text = "City"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        return label
    }()
    
    private let airQualityIndex: UILabel = {
        let label = UILabel()
        label.text = "AQI"
        label.textColor = UIColor(red: 96/255.0, green: 217/255.0, blue: 37/255.0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48, weight: .medium)
        return label
    }()
    
    private let airQualityIndexDescription: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private var viewModel: AirQualityDetailsViewModel?
    
    init(city: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel = AirQualityDetailsViewModel()
        viewModel?.delegate = self
        viewModel?.fetchAirQualityData(for: city)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupBackground()
        addMainSubview()
        setupMainViewConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.backgroundColor
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

//MARK: - AirQualityDetailsViewModelDelegate
extension AirQualityDetailsViewController: AirQualityDetailsViewModelDelegate {
    func airQualityDataFetched(_ airQualityData: AirQualityModel) {
        Task {
            await MainActor.run {
                self.cityTitleLabel.text = airQualityData.data.city
                self.airQualityIndex.text = "\(airQualityData.data.current.pollution.aqius)"
                
                let aqius = airQualityData.data.current.pollution.aqius
                let airQualityDescription = viewModel?.getAirQualityDescription(forAQI: aqius)
                self.airQualityIndexDescription.text = airQualityDescription
            }
        }
    }
    
    func showError(_ error: Error) {
        print("Error fetching air quality data")
    }
}

