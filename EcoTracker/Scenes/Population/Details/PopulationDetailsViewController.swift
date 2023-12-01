//
//  PopulationDetailsViewController.swift
//  EcoTracker
//
//  Created by Nikoloz Gachechiladze on 30.11.23.
//

import UIKit

final class PopulationDetailsViewController: UIViewController {
    
    var country: String?
    var detailsViewModel = PopulationDetailsViewModel()
    
    //MARK: - UI Elements
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let todayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 40
        return stackView
    }()
    
    private let tomorrowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 40
        return stackView
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        return label
    }()
    
    private let populationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        return label
    }()
    
    private let dateLabelFuture: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        return label
    }()
    
    private let populationLabelFuture: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setup()
    }
    
    //MARK: Setup UI
    
    private func setup() {
        setupUI()
        setupConstraints()
        setupCountryLabel()
        detailsViewModel.delegate = self
        detailsViewModel.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(countryLabel)
        mainStackView.addArrangedSubview(todayStackView)
        todayStackView.addArrangedSubview(dateLabel)
        todayStackView.addArrangedSubview(populationLabel)
        mainStackView.addArrangedSubview(tomorrowStackView)
        tomorrowStackView.addArrangedSubview(dateLabelFuture)
        tomorrowStackView.addArrangedSubview(populationLabelFuture)
        mainStackView.addArrangedSubview(statusLabel)
    }
    
    private func setupCountryLabel() {
        countryLabel.text = country
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 202),
            mainStackView.widthAnchor.constraint(equalToConstant: 343),
        ])
    }
    
}

//MARK: - Extension - PopulationDetailsViewModelDelegate

extension PopulationDetailsViewController: PopulationDetailsViewModelDelegate {
    func viewModelDidUpdateTodayDetails(_ date: String, population: String) {
        dateLabel.text = date
        populationLabel.text = population
    }
    
    func viewModelDidUpdateTomorrowDetails(_ date: String, population: String) {
        dateLabelFuture.text = date
        populationLabelFuture.text = population
    }
    
    func viewModelDidUpdateStatus() {
        statusLabel.text = detailsViewModel.status
    }
    
    
}
