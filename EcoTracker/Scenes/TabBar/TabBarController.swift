//
//  TabBarController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 29.11.23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupUI()
    }
    
    // MARK: - Tab Setup
    private func setupTabs() {
        let airQuality = createNavigationController(title: "Air Quality", image: UIImage(named: "AirQuality"), viewController: AirQualityViewController())
        let weather = createNavigationController(title: "Weather", image: UIImage(named: "Weather"), viewController: WeatherViewController())
        let species = createNavigationController(title: "Species", image: UIImage(named: "Species"), viewController: SpeciesViewController())
        let solarResources = createNavigationController(title: "Solar Resources", image: UIImage(named: "SolarResources"), viewController: SolarResourcesViewController())
        let population = createNavigationController(title: "Population", image: UIImage(named: "Population"), viewController: PopulationViewController())
        setViewControllers([airQuality, weather, species, solarResources, population], animated: true)
    }
    
    // MARK: - NavigationController Setup
    private func createNavigationController(title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.viewControllers.first?.navigationItem.title = title
        return navigationController
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        tabBar.tintColor = UIColor.componentsColor
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
        tabBar.standardAppearance = createTabBarAppearance()
        tabBar.scrollEdgeAppearance = createTabBarScrollEdgeAppearance()
    }
    
    private func createTabBarAppearance() -> UITabBarAppearance {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.accentColor
        return tabBarAppearance
    }

    private func createTabBarScrollEdgeAppearance() -> UITabBarAppearance {
        let tabBarScrollEdgeAppearance = UITabBarAppearance()
        tabBarScrollEdgeAppearance.backgroundColor = UIColor.accentColor
        return tabBarScrollEdgeAppearance
    }
}


