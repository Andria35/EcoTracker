//
//  SpeciesDetailsViewController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import UIKit

final class SpeciesDetailsViewController: UIViewController {
    // MARK: - Class Properties
    private var speciesDetails = [SpecieDetails]()
    private let viewModel: SpeciesDetailsViewModel
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.backgroundColor
        return tableView
    }()
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupDelegates()
        viewModel.viewDidLoad()
    }
    
    init(cityIds: [Int]) {
        viewModel = SpeciesDetailsViewModel(cityIds: cityIds)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Setup UI
    private func setupUI() {
        setupBackground()
        setupSubviews()
        setupTableView()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.backgroundColor
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(SpeciesDetailsTableViewCell.self, forCellReuseIdentifier: SpeciesDetailsTableViewCell.cellId)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: - Setup Delegates
    private func setupDelegates() {
        viewModel.delegate = self
    }
    
    // MARK: - Class Methods
}

// MARK: - TableView DataSource
extension SpeciesDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        speciesDetails.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let specieDetails = speciesDetails[indexPath.row]
        cell = tableView.dequeueReusableCell(withIdentifier: SpeciesDetailsTableViewCell.cellId, for: indexPath)
        if let cell = cell as? SpeciesDetailsTableViewCell {
            cell.configure(with: specieDetails)
        }
        return cell
    }
}

// MARK: - SpeciesDetailsViewModelDelegate
extension SpeciesDetailsViewController: SpeciesDetailsViewModelDelegate {
    func speciesDetailsFetched(speciesDetails: [SpecieDetails]) {
        self.speciesDetails = speciesDetails
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print(error)
    }
    
    
}
