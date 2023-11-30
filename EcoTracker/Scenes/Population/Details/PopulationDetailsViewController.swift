//
//  PopulationDetailsViewController.swift
//  EcoTracker
//
//  Created by Nikoloz Gachechiladze on 30.11.23.
//

import UIKit

final class PopulationDetailsViewController: UIViewController {
    
    var populationData: PopulationData?
    var country: String?

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
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setup()
    }
    
    private func setup() {
        setupUI()
        setupConstraints()
        setupLabels()
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
    }
    
    private func setupLabels() {
        if let country = country {
            countryLabel.text = country
        }
        if let firstPopulation = populationData?.totalPopulation.first {
            dateLabel.text = "Today: \(String(firstPopulation.date))".replacingOccurrences(of: "-", with: ".")
            populationLabel.text = String(firstPopulation.population)
        }
        if let secondPopulation = populationData?.totalPopulation.last {
            dateLabelFuture.text = "Tomorrow: \(String(secondPopulation.date))".replacingOccurrences(of: "-", with: ".")
            populationLabelFuture.text = String(secondPopulation.population)
        }
        
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
