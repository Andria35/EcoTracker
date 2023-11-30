//
//  SpeciesDetailsViewController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import UIKit

final class SpeciesDetailsViewController: UIViewController {
    // MARK: - Class Properties
    private let speciesDetails = [SpeciesDetails]()
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
//        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: HomePageTableViewCell.cellId)
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
    
    // MARK: - Class Methods
}

// MARK: - TableView DataSource
extension SpeciesDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        catFacts.count
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
//        let catFact = catFacts[indexPath.row].fact
//        cell = tableView.dequeueReusableCell(withIdentifier: HomePageTableViewCell.cellId, for: indexPath)
//        if let cell = cell as? HomePageTableViewCell {
//            cell.configure(with: catFact)
//        }
        return cell
    }
}
