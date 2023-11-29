//
//  TabBarController.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 29.11.23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupUI()
    }
    
    // MARK: - Tab Setup
    private func setupTabs() {
        let airQuality = createNav(title: "Air Quality", image: UIImage(named: "AirQuality"), viewController: AirQualityViewController())
        let weather = createNav(title: "Weather", image: UIImage(named: "Weather"), viewController: WeatherViewController())
        
        let species = createNav(title: "Species", image: UIImage(named: "Species"), viewController: SpeciesViewController())
        
        let solarResources = createNav(title: "Solar Resources", image: UIImage(named: "SolarResources"), viewController: SolarResourcesViewController())
        
        let population = createNav(title: "Population", image: UIImage(named: "Population"), viewController: PopulationViewController())
        
        setViewControllers([airQuality, weather, species, solarResources, population], animated: true)
    }
    
    private func createNav(title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        
        return nav
    }
    
    private func setupUI() {
        tabBar.backgroundColor = UIColor.secondaryBackgroundColor
        tabBar.tintColor = UIColor.componentsColor
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.textColor
        ]
    }
}
