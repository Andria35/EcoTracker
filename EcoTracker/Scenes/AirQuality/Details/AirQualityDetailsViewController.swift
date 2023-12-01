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
        label.text = ""
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        return label
    }()
    
    private let airQualityIndex: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 96/255.0, green: 217/255.0, blue: 37/255.0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48, weight: .medium)
        return label
    }()
    
    private let airQualityIndexDescription: UILabel = {
        let label = UILabel()
        label.text = ""
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

//MARK: - AirQualityDetailsViewModelDelegate
extension AirQualityDetailsViewController: AirQualityDetailsViewModelDelegate {
    func airQualityDataFetched(_ airQualityData: AirQualityModel) {
        Task {
            await MainActor.run {
                self.cityTitleLabel.text = airQualityData.data.city
                self.airQualityIndex.text = "\(airQualityData.data.current.pollution.aqius)"
                
                let aqius = airQualityData.data.current.pollution.aqius
                let airQualityDescription: String

                switch aqius {
                case 0...50:
                    airQualityDescription = "Air quality is great, no significant health risk. Enjoy outdoor activities!"
                case 51...100:
                    airQualityDescription = "Air quality is acceptable; however, there may be some concern for very sensitive individuals. Unusually sensitive people should consider limiting prolonged outdoor exertion."
                case 101...150:
                    airQualityDescription = "Members of sensitive groups may experience health effects. The general public is less likely to be affected."
                case 151...200:
                    airQualityDescription = "Everyone may begin to experience adverse health effects, and members of sensitive groups may experience more serious effects. Avoid prolonged outdoor exertion; everyone else, especially children, should limit outdoor exertion."
                case 201...250:
                    airQualityDescription = "Health alert: everyone may experience more serious health effects. Everyone should avoid outdoor activities, and members of sensitive groups should avoid all outdoor exertion."
                case 251...300:
                    airQualityDescription = "Health warnings of emergency conditions. The entire population is likely to be affected. Avoid all outdoor activities, and remain indoors as much as possible."
                case 301...500:
                    airQualityDescription = "Health alert: everyone may experience more serious health effects. The health warnings of emergency conditions; the entire population is more likely to be affected."
                default:
                    airQualityDescription = "Air quality information not available."
                }

                self.airQualityIndexDescription.text = airQualityDescription
            }
        }
    }
    
    func showError(_ error: Error) {
        print("Error: /(error)")
    }
}

