//
//  SpecieViewController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 29.11.23.
//

import UIKit

final class SpeciesViewController: UIViewController {
    
    // MARK: - Class Properties
    private let viewModel = SpeciesViewModel()
    
    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SpeciesPageBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let discoverSpeciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover Species In Your City!"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .textColor
        return label
    }()
    
    private let cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Your City Name"
        textField.textColor = UIColor.textColor
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.backgroundColor = UIColor.textFieldBackgroundColor.cgColor
        textField.layer.borderColor = UIColor.textfieldStrokeColor.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private let findSpeciesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find Species", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-Bold", size: 14)
        button.titleLabel?.textColor = UIColor.textColor
        button.backgroundColor = UIColor.buttonBackgroundColor
        button.layer.cornerRadius = 6
        return button
    }()

    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupDelegates()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupBackground()
        setupSubViews()
    }
    
    private func setupSubViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(discoverSpeciesLabel)
        mainStackView.addArrangedSubview(cityTextField)
        mainStackView.addArrangedSubview(findSpeciesButton)
    }
    
    private func setupBackground() {
        view.backgroundColor = .backgroundColor
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        setupFindSpeciesAction()
    }
    
    private func setupFindSpeciesAction() {
        findSpeciesButton.addAction(UIAction(handler: { [weak self] action in
            self?.viewModel.findSpeciesButtonPressed(cityName: self?.cityTextField.text)
        }), for: .touchUpInside)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        setupBackgroundImageViewConstraints()
        setupMainStackViewConstraints()
        setupCityTextFieldConstraints()
        setupFindSpeciesButtonConstraints()
    }
    
    private func setupBackgroundImageViewConstraints() {
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupCityTextFieldConstraints() {
        cityTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
    }
    
    private func setupFindSpeciesButtonConstraints() {
        findSpeciesButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        findSpeciesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        findSpeciesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
    }
    
    // MARK: - Setup Delegates
    private func setupDelegates() {
        viewModel.delegate = self
    }
    
    // MARK: - Class Methods
    private func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - SpeciesViewModel Delegate
extension SpeciesViewController: SpeciesViewModelDelegate {
    func cityIdsFetched(_ cityIds: [Int]) {
        let nextVC = SpeciesDetailsViewController(cityIds: cityIds)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func cityIdsNotFetched() {
        displayAlert(title: "Invalid City Name!", message: "Please Input Existing City Name🙏")
        cityTextField.text = ""
    }
    
    func showError(_ error: Error) {
        print(error)
    }
}
