//
//  WeatherViewController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 29.11.23.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    private let weatherViewModel = WeatherViewModel()

    private let latitudeTextField = CustomTextField()
    private let longitudeTextField = CustomTextField()
    private let getWeatherButton = UIButton()
    private let typeTextLabel = UILabel()
    private let degreeLabel = UILabel()
    private let placeNameLabel = UILabel()
    private let weatherDescription = UILabel()
    private let typeCityTextField = CustomTextField()
    private let enterCoordinatesLabel = UILabel()
    private let getInformationStackView = UIStackView()
    private let coordinatesStackView = UIStackView()
    private let imagestackView = UIStackView()
    private let weatherImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        weatherViewModel.delegate = self
        
        setupDegreeLabel()
        setupPlaceNameLabel()
        setupGetInformationStackView()
        seupImageStackView()
        setupWeatherImage()
        setupConstrains()
    }
    
    // MARK: - StackView Setups
    private func setupGetInformationStackView() {
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
    
    private func setupCoordinatesStackView() {
        getInformationStackView.addArrangedSubview(coordinatesStackView)
        coordinatesStackView.axis = .horizontal
        coordinatesStackView.distribution = .fillEqually
        coordinatesStackView.spacing = 12
        
        setupLatitudeTextField()
        setupLongitudeTextField()
    }
    
    func seupImageStackView() {
        view.addSubview(imagestackView)
        imagestackView.translatesAutoresizingMaskIntoConstraints = false
        imagestackView.alignment = .center
    }
    
    // MARK: - Setup image
    func setupWeatherImage() {
        imagestackView.addArrangedSubview(weatherImage)
        weatherImage.image = UIImage(named: "sunny-cloudy")
    }
   
    // MARK: - Labels setups
    private func setupDegreeLabel() {
        view.addSubview(degreeLabel)
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.font = .systemFont(ofSize: 72, weight: .bold)
        degreeLabel.textColor = .textColor
        degreeLabel.text = "19°"
    }
    
    private func setupPlaceNameLabel() {
        view.addSubview(placeNameLabel)
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        placeNameLabel.textColor = .textColor
        placeNameLabel.text = "Tbilisi"
    }

    private func setupTypeTextLabel() {
        getInformationStackView.addArrangedSubview(typeTextLabel)
        typeTextLabel.font = .systemFont(ofSize: 14, weight: .regular)
        typeTextLabel.textColor = .textColor
        typeTextLabel.text = "or type your city name"
    }
    
    private func setupEnterCoordinatesLabel() {
        getInformationStackView.addArrangedSubview(enterCoordinatesLabel)
        enterCoordinatesLabel.font = .systemFont(ofSize: 16, weight: .bold)
        enterCoordinatesLabel.text = "Enter Coordinates"
        enterCoordinatesLabel.textColor = .textColor
    }
    
    // MARK: - TextFields Setups
    private func setupTypeCityTextField() {
        getInformationStackView.addArrangedSubview(typeCityTextField)
        typeCityTextField.placeholder = "Enter the city"
    }
    
    private func setupLatitudeTextField()  {
        coordinatesStackView.addArrangedSubview(latitudeTextField)
        latitudeTextField.placeholder = "Enter Latitude"
    }
    
    private func setupLongitudeTextField() {
        coordinatesStackView.addArrangedSubview(longitudeTextField)
        longitudeTextField.placeholder = "Enter Longitude"
    }
    
    // MARK: - button Setup
    private func setupGetWeatherButton() {
        getInformationStackView.addArrangedSubview(getWeatherButton)
        getWeatherButton.setTitle("Get Weather Forecast", for: .normal)
        getWeatherButton.layer.cornerRadius = 6
        getWeatherButton.backgroundColor = .buttonBackgroundColor
        getWeatherButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        getWeatherButton.addAction(UIAction(handler: { action in
            let cityName = self.typeCityTextField.text
            let long = self.longitudeTextField.text
            let lat = self.latitudeTextField.text
            
            if cityName == "" && (long == "" || lat == "") {
               print ("Please enter correct info")
            } else {
                self.weatherViewModel.fetchData(long: long ?? "", lat: lat ?? "", cityName: cityName ?? "")
            }
        }), for: .touchUpInside)
    }
    
    
    
    // MARK: - Constrains
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            degreeLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 8),
            degreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            placeNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 193),
            placeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            getInformationStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 252),
            getInformationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            getInformationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            imagestackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            imagestackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            coordinatesStackView.leadingAnchor.constraint(equalTo: getInformationStackView.leadingAnchor, constant: 12),
            coordinatesStackView.trailingAnchor.constraint(equalTo: getInformationStackView.trailingAnchor, constant: -12),
            
            typeCityTextField.leadingAnchor.constraint(equalTo: getInformationStackView.leadingAnchor, constant: 12),
            typeCityTextField.trailingAnchor.constraint(equalTo: getInformationStackView.trailingAnchor, constant: -12),
 
            getWeatherButton.heightAnchor.constraint(equalToConstant: 48),
            getWeatherButton.leadingAnchor.constraint(equalTo: getInformationStackView.leadingAnchor, constant: 12),
            getWeatherButton.trailingAnchor.constraint(equalTo: getInformationStackView.trailingAnchor, constant: -12),

        ])
    }

    func reloadData() {
        degreeLabel.text = "\(weatherViewModel.weatherInfo?.main.temp ?? 0)°"
        placeNameLabel.text = weatherViewModel.weatherInfo?.name
    }
}

extension WeatherViewController: dataFetchDelegate {
    func fetchCompleted() async {
        await MainActor.run {
            self.reloadData()
        }
    }

    func fetchFailed(error: Error) {
        print (error)
    }
}
