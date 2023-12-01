//
//  AirQualityViewController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 29.11.23.
//

import UIKit

final class AirQualityViewController: UIViewController {
    
    // MARK: - Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private let airQualityLabel: UILabel = {
        let label = UILabel()
        label.text = "Air Quality Index (AQI)"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let airQualityImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor.accentColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let airQualityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AQI")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let checkAirQualityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.accentColor
        stackView.spacing = 24
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let checkAirQualityLabel: UILabel = {
        let label = UILabel()
        label.text = "Check Air Quality"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let locationTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.textfieldStrokeColor.cgColor
        textField.backgroundColor = UIColor.textFieldBackgroundColor
        textField.textColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Any Location",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(red: 114/255.0, green: 121/255.0, blue: 134/255.0, alpha: 1),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)
            ])
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let checkAirQualityButton: UIButton = {
        let button = UIButton()
        button.setTitle("Check Air Quality", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.buttonBackgroundColor
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let healthIssuesLabel: UILabel = {
        let label = UILabel()
        label.text = "Health Impacts of Poor Air Quality"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let healthIssuesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let respiratoryAndCardioProblemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let respiratoryIssuesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Respiratory Issues", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 35/255.0, green: 37/255.0, blue: 73/255.0, alpha: 1)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let cardiovascularProblemsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cardiovascular Problems", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 35/255.0, green: 37/255.0, blue: 73/255.0, alpha: 1)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let childhoodAndPregnancyProblemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let childhoodVulnerabilityButton: UIButton = {
        let button = UIButton()
        button.setTitle("Childhood Vulnerability", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 35/255.0, green: 37/255.0, blue: 73/255.0, alpha: 1)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let pregnancyConcernsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pregnancy Concerns", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 35/255.0, green: 37/255.0, blue: 73/255.0, alpha: 1)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let lungProblemsAndHospitalAdmissionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let reducedLungFunctionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reduced Lung Function", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 35/255.0, green: 37/255.0, blue: 73/255.0, alpha: 1)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let hospitalAdmissionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hospital Admissions", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 35/255.0, green: 37/255.0, blue: 73/255.0, alpha: 1)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let airQualitySensorsLabel: UILabel = {
        let label = UILabel()
        label.text = "Air Quality Sensors"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let pmStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.accentColor
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let pmTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "PM10")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 0, length: 2))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 10), range: NSRange(location: 2, length: 2))
        label.attributedText = attributedString
        label.textColor = UIColor(red: 96/255.0, green: 217/255.0, blue: 37/255.0, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let pmDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Particulate Matter measures the concentration of inhalable particles with diameters generally 10 micrometers and smaller. These particles, including dust and pollen, can impact respiratory health. Stay informed about PM10 levels for a clearer understanding of air quality."
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let ozoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.accentColor
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let ozoneTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "O3")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 0, length: 1))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 10), range: NSRange(location: 1, length: 1))
        label.attributedText = attributedString
        label.textColor = UIColor(red: 96/255.0, green: 217/255.0, blue: 37/255.0, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let ozoneDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Ozone is a reactive gas that can be beneficial in the stratosphere but harmful at ground level. Ground-level ozone, a key component of smog, can affect respiratory health. Monitor O3 levels to assess potential air quality impacts."
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let soStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.accentColor
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let soTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "SO2")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 0, length: 2))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 10), range: NSRange(location: 2, length: 1))
        label.attributedText = attributedString
        label.textColor = UIColor(red: 96/255.0, green: 217/255.0, blue: 37/255.0, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let soDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sulfur Dioxide  is a gas produced by burning fossil fuels containing sulfur. Exposure to high levels can irritate the respiratory system. Keep an eye on SO2 levels to understand potential air pollution in your area."
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let noStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.accentColor
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let noTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "NO2")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 0, length: 2))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 10), range: NSRange(location: 2, length: 1))
        label.attributedText = attributedString
        label.textColor = UIColor(red: 96/255.0, green: 217/255.0, blue: 37/255.0, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let noDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sulfur Dioxide  is a gas produced by burning fossil fuels containing sulfur. Exposure to high levels can irritate the respiratory system. Keep an eye on SO2 levels to understand potential air pollution in your area."
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private var city: DataClass?
    
    private let viewModel = AirQualityViewModel()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupBackground()
        addSubviews()
        setupConstraints()
        setupViewModelDelegate()
        setupCheckAirQualityButton()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.backgroundColor
    }
    
    private func addSubviews() {
        addMainSubview()
        setupAirQualityIndexStackView()
        setupCheckQualityStackView()
        setupHealthImpactsStackView()
        setupAirQualitySensorsStackView()
        setupViewModelDelegate()
    }
    
    private func addMainSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
    }
    
    private func setupAirQualityIndexStackView() {
        airQualityImageStackView.addArrangedSubview(airQualityImageView)
        mainStackView.addArrangedSubview(airQualityLabel)
        mainStackView.addArrangedSubview(airQualityImageStackView)
    }
    
    private func setupCheckQualityStackView() {
        mainStackView.addArrangedSubview(checkAirQualityStackView)
        checkAirQualityStackView.addArrangedSubview(checkAirQualityLabel)
        checkAirQualityStackView.addArrangedSubview(locationTextField)
        checkAirQualityStackView.addArrangedSubview(checkAirQualityButton)
    }
    
    private func setupHealthImpactsStackView() {
        mainStackView.addArrangedSubview(healthIssuesLabel)
        mainStackView.addArrangedSubview(healthIssuesStackView)
        
        healthIssuesStackView.addArrangedSubview(respiratoryAndCardioProblemsStackView)
        respiratoryAndCardioProblemsStackView.addArrangedSubview(respiratoryIssuesButton)
        respiratoryAndCardioProblemsStackView.addArrangedSubview(cardiovascularProblemsButton)
        
        healthIssuesStackView.addArrangedSubview(childhoodAndPregnancyProblemsStackView)
        childhoodAndPregnancyProblemsStackView.addArrangedSubview(childhoodVulnerabilityButton)
        childhoodAndPregnancyProblemsStackView.addArrangedSubview(pregnancyConcernsButton)
        
        healthIssuesStackView.addArrangedSubview(lungProblemsAndHospitalAdmissionsStackView)
        lungProblemsAndHospitalAdmissionsStackView.addArrangedSubview(reducedLungFunctionButton)
        lungProblemsAndHospitalAdmissionsStackView.addArrangedSubview(hospitalAdmissionsButton)
    }
    
    private func setupAirQualitySensorsStackView() {
        mainStackView.addArrangedSubview(airQualitySensorsLabel)
        mainStackView.addArrangedSubview(pmStackView)
        pmStackView.addArrangedSubview(pmTitleLabel)
        pmStackView.addArrangedSubview(pmDescriptionLabel)
        
        mainStackView.addArrangedSubview(ozoneStackView)
        ozoneStackView.addArrangedSubview(ozoneTitleLabel)
        ozoneStackView.addArrangedSubview(ozoneDescriptionLabel)
        
        mainStackView.addArrangedSubview(soStackView)
        soStackView.addArrangedSubview(soTitleLabel)
        soStackView.addArrangedSubview(soDescriptionLabel)
        
        mainStackView.addArrangedSubview(noStackView)
        noStackView.addArrangedSubview(noTitleLabel)
        noStackView.addArrangedSubview(noDescriptionLabel)
    }
    
    private func setupConstraints() {
        setupMainViewConstraints()
        setupAirQualityImageConstraints()
        setupCheckQualityComponentsConstraints()
        setupHealthIssuesButtonsConstraints()
        customizeStackViewSpacing()
    }
    
    private func setupMainViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupAirQualityImageConstraints() {
        NSLayoutConstraint.activate([
            airQualityImageView.heightAnchor.constraint(equalToConstant: 182),
            airQualityImageView.widthAnchor.constraint(equalToConstant: 296)
        ])
    }
    
    private func setupCheckQualityComponentsConstraints() {
        NSLayoutConstraint.activate([
            locationTextField.heightAnchor.constraint(equalToConstant: 48),
            checkAirQualityButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupHealthIssuesButtonsConstraints() {
        NSLayoutConstraint.activate([
            respiratoryIssuesButton.heightAnchor.constraint(equalToConstant: 44),
            cardiovascularProblemsButton.heightAnchor.constraint(equalToConstant: 44),
            childhoodVulnerabilityButton.heightAnchor.constraint(equalToConstant: 44),
            pregnancyConcernsButton.heightAnchor.constraint(equalToConstant: 44),
            reducedLungFunctionButton.heightAnchor.constraint(equalToConstant: 44),
            hospitalAdmissionsButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func customizeStackViewSpacing() {
        mainStackView.setCustomSpacing(12, after: airQualityLabel)
        mainStackView.setCustomSpacing(12, after: healthIssuesLabel)
        mainStackView.setCustomSpacing(12, after: airQualitySensorsLabel)
        mainStackView.setCustomSpacing(16, after: pmStackView)
        mainStackView.setCustomSpacing(16, after: ozoneStackView)
        mainStackView.setCustomSpacing(16, after: soStackView)
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
    
    private func setupCheckAirQualityButton() {
        checkAirQualityButton.addAction(UIAction(title: "Check Air Quality", handler: { [weak self] action in
            Task {
                await self?.viewModel.checkAirQualityButtonDidTap(text: self?.locationTextField.text ?? "")
            }
        }), for: .touchUpInside)
    }
}

//MARK: - AirQualityViewModelDelegate
extension AirQualityViewController: AirQualityViewModelDelegate {
    func cityFetched(_ city: DataClass) {
        self.city = city
    }
    
    func showError(_ error: Error) {
        print("Sorry, only California Cities are available 🌝")
    }
    
    func navigateToDetailsPage(with city: String) {
        let detailsViewController = AirQualityDetailsViewController(city: city)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}


