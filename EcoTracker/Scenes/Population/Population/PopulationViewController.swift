//
//  PopulationViewController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 29.11.23.
//

import UIKit

final class PopulationViewController: UIViewController {
    
    private var countries: [String] = []
    private let viewModel = PopulationViewModel()
    private var populationData = PopulationData(totalPopulation: [])
    private var selectedCountry: String?
    
    //MARK: - UI Elements
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a Country to get their population"
        label.textAlignment = .center
        label.textColor = .textColor
        return label
    }()
    
    private var selectedCountryTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.textfieldStrokeColor.cgColor
        textField.layer.cornerRadius = 6.0
        textField.backgroundColor = UIColor.textfieldBackgroundColor
        textField.inputView = UIPickerView()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Select a Country", attributes: placeholderAttributes)
        return textField
    }()
    
    private var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private var populationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get the Population", for: .normal)
        button.backgroundColor = .buttonBackgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6
        return button
    }()
    
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - UI Setup
    
    private func setup() {
        setupUI()
        setupConstraints()
        setupButton()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainLabel)
        mainStackView.addArrangedSubview(selectedCountryTextField)
        mainStackView.addArrangedSubview(populationButton)
        setupPickerView()
        mainStackView.setCustomSpacing(24, after: selectedCountryTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            populationButton.heightAnchor.constraint(equalToConstant: 48),
            selectedCountryTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        setupPickerCountries()
    }
    
    private func setupPickerCountries() {
        Task {
            do {
                try await viewModel.viewDidLoad()
                await MainActor.run {
                    self.pickerView.reloadAllComponents()
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func setupButton() {
        populationButton.addAction(UIAction(handler: { [weak self] _ in
            self?.buttonTapped()
        }), for: .touchUpInside)
    }
    
    private func buttonTapped() {
        viewModel.didTapPopulationButton(country: selectedCountryTextField.text ?? "Georgia")
    }
    
    
}

//MARK: - Extension: UIPickerViewDelegate

extension PopulationViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = countries[row]
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = countries[row]
        selectedCountryTextField.text = selectedCountry
        selectedCountryTextField.textColor = .textColor
        selectedCountryTextField.resignFirstResponder()
        viewModel.selectedCountry = selectedCountry
    }
}

//MARK: - Extension: UIPickerViewDataSource

extension PopulationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
    
}

//MARK: - Extension: PopulationViewModelDelegate

extension PopulationViewController: PopulationViewModelDelegate {
    
    func didTapPopulationButton(_ population: PopulationData) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let pushedVC = PopulationDetailsViewController()
            pushedVC.detailsViewModel.populationData = population
            pushedVC.country = self.selectedCountryTextField.text
            pushedVC.configure(population: population)
            self.navigationController?.pushViewController(pushedVC, animated: true)
        }
    }

    
    
    func didFetchPopulation(_ population: PopulationData) {
        self.populationData = population
    }
    
    
    func didFetchCountries(_ countries: CountryResponse) {
        self.countries = countries.countries
        DispatchQueue.main.async{
            self.selectedCountryTextField.inputView = self.pickerView
        }
    }
    
}




