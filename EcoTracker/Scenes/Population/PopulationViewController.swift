//
//  PopulationViewController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 29.11.23.
//

import UIKit

final class PopulationViewController: UIViewController {
    
    private let countries = ["Germany", "Spain", "Italy", "Switzerland"]
    
    //MARK: - UI Elements
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
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
        textField.layer.cornerRadius = 5.0
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
        button.layer.cornerRadius = 5
        return button
    }()
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    //MARK: - UI Setup
    
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
            mainStackView.heightAnchor.constraint(equalToConstant: 202),
            mainStackView.widthAnchor.constraint(equalToConstant: 343),
            populationButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -12),
            populationButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 12),
            populationButton.heightAnchor.constraint(equalToConstant: 48),
            selectedCountryTextField.heightAnchor.constraint(equalToConstant: 48),
            selectedCountryTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -12),
            selectedCountryTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 12)
        ])
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        selectedCountryTextField.inputView = pickerView
    }
    
}

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
    }
}

extension PopulationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
    
}
