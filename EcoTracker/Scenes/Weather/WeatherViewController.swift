//
//  WeatherViewController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 29.11.23.
//

import UIKit

final class WeatherViewController: UIViewController {

    private let latitudeTextField = CustomTextField()
    private let longitudeTextField = CustomTextField()
    private let getWeatherButton = UIButton()
    private let typeTextLabel = UILabel()
    private let degreeLabel = UILabel()
    private let placeNameLabel = UILabel()
    private let weatherDescription = UILabel()
    private let weahtherTypeLabel = UILabel()
    private let typeCityTextField = CustomTextField()
    private let enterCoordinatesLabel = UILabel()
    private let getInformationStackView = UIStackView()
    private let coordinatesStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        setupDegreeLabel()
        setupPlaceNameLabel()
        setupGetInformationStackView()
        setupConstrains()
    }
    
    // MARK: - StackView Setups
    func setupGetInformationStackView() {
        view.addSubview(getInformationStackView)
        
        getInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        getInformationStackView.alignment = .center
        getInformationStackView.backgroundColor = .accentColor
        getInformationStackView.axis = .vertical
        getInformationStackView.spacing = 16
        getInformationStackView.layoutMargins = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
        getInformationStackView.isLayoutMarginsRelativeArrangement = true
        getInformationStackView.layer.cornerRadius = 8
        
        setupEnterCoordinatesLabel()
        setupCoordinatesStackView()
        setupTypeTextLabel()
        setupTypeCityTextField()
        setupGetWeatherButton()
    }
    
    func setupCoordinatesStackView() {
        getInformationStackView.addArrangedSubview(coordinatesStackView)
        coordinatesStackView.axis = .horizontal
        coordinatesStackView.distribution = .fillEqually
        coordinatesStackView.spacing = 11
        
        setupLatitudeTextField()
        setupLongitudeTextField()
    }
   
    // MARK: - Labels setups
    func setupDegreeLabel() {
        view.addSubview(degreeLabel)
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.font = .systemFont(ofSize: 72, weight: .bold)
        degreeLabel.textColor = .textColor
        degreeLabel.text = "19°"
    }
    
    func setupPlaceNameLabel() {
        view.addSubview(placeNameLabel)
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        placeNameLabel.textColor = .textColor
        placeNameLabel.text = "Tbilisi"
    }

    func setupTypeTextLabel() {
        getInformationStackView.addArrangedSubview(typeTextLabel)
        typeTextLabel.font = .systemFont(ofSize: 14, weight: .regular)
        typeTextLabel.textColor = .textColor
        typeTextLabel.text = "or type your city name"
    }
    
    func setupEnterCoordinatesLabel() {
        getInformationStackView.addArrangedSubview(enterCoordinatesLabel)
        enterCoordinatesLabel.font = .systemFont(ofSize: 16, weight: .bold)
        enterCoordinatesLabel.text = "Enter Coordinates"
        enterCoordinatesLabel.textColor = .textColor
    }
    
    // MARK: - TextFields Setups
    func setupTypeCityTextField() {
        getInformationStackView.addArrangedSubview(typeCityTextField)
        typeCityTextField.placeholder = "Enter the city"
    }
    
    func setupLatitudeTextField()  {
        coordinatesStackView.addArrangedSubview(latitudeTextField)
        latitudeTextField.placeholder = "Enter Latitude"
    }
    
    func setupLongitudeTextField() {
        coordinatesStackView.addArrangedSubview(longitudeTextField)
        longitudeTextField.placeholder = "Enter Longitude"
    }
    
    // MARK: - button Setup
    func setupGetWeatherButton() {
        getInformationStackView.addArrangedSubview(getWeatherButton)
        getWeatherButton.setTitle("Get Weather Forecast", for: .normal)
        getWeatherButton.layer.cornerRadius = 6
        getWeatherButton.backgroundColor = .buttonBackgroundColor
        getWeatherButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    // MARK: - Constrains
    func setupConstrains() {
        NSLayoutConstraint.activate([
            degreeLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 8),
            degreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            placeNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 193),
            placeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            getInformationStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 252),
            getInformationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            getInformationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            coordinatesStackView.leadingAnchor.constraint(equalTo: getInformationStackView.leadingAnchor, constant: 12),
            coordinatesStackView.trailingAnchor.constraint(equalTo: getInformationStackView.trailingAnchor, constant: -12),
            
            typeCityTextField.leadingAnchor.constraint(equalTo: getInformationStackView.leadingAnchor, constant: 12),
            typeCityTextField.trailingAnchor.constraint(equalTo: getInformationStackView.trailingAnchor, constant: -12),
 
            getWeatherButton.heightAnchor.constraint(equalToConstant: 48),
            getWeatherButton.leadingAnchor.constraint(equalTo: getInformationStackView.leadingAnchor, constant: 12),
            getWeatherButton.trailingAnchor.constraint(equalTo: getInformationStackView.trailingAnchor, constant: -12),
        ])
    }
}
