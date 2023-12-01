//
//  PopulationDetailsViewModel.swift
//  EcoTracker
//
//  Created by Nikoloz Gachechiladze on 30.11.23.
//
import Foundation

//MARK: - PopulationDetailsViewModelDelegate Protocol

protocol PopulationDetailsViewModelDelegate: AnyObject {
    func viewModelDidUpdateTodayDetails(_ date: String, population: String)
    func viewModelDidUpdateTomorrowDetails(_ date: String, population: String)
    func viewModelDidUpdateStatus()
}

final class PopulationDetailsViewModel {
    
    //MARK: - Properties
    
    var populationData: PopulationData?
    var status: String = ""
    weak var delegate: PopulationDetailsViewModelDelegate?
    
    //MARK: - Methods
    
    func viewDidLoad() {
        comparePopulationData()
        fetchPopulationDetails()
    }
    
    private func comparePopulationData() {
        if let firstPopulation = populationData?.totalPopulation.first?.population,
           let secondPopulation = populationData?.totalPopulation.last?.population {
            if firstPopulation <= secondPopulation {
                status = "Population is growing! 😊"
            } else {
                status = "Population is declining. 😞"
            }
        }
        delegate?.viewModelDidUpdateStatus()
    }
    
    private func getTodayPopulationDetails() -> (date: String, population: String)? {
        guard let firstPopulation = populationData?.totalPopulation.first else {
            return nil
        }
        let date = "Today: \(String(firstPopulation.date))".replacingOccurrences(of: "-", with: ".")
        let population = "\(firstPopulation.population)"
        delegate?.viewModelDidUpdateTodayDetails(date, population: population)
        return (date, population)
    }
    
    
    private func getTomorrowPopulationDetails() -> (date: String, population: String)? {
        guard let secondPopulation = populationData?.totalPopulation.last else {
            return nil
        }
        let date = "Tomorrow: \(String(secondPopulation.date))".replacingOccurrences(of: "-", with: ".")
        let population = "\(secondPopulation.population)"
        delegate?.viewModelDidUpdateTomorrowDetails(date, population: population)
        return (date, population)
    }
    
    private func fetchPopulationDetails() {
        if let todayDetails = getTodayPopulationDetails(),
           let tomorrowDetails = getTomorrowPopulationDetails() {
            delegate?.viewModelDidUpdateTodayDetails(todayDetails.date, population: todayDetails.population)
            delegate?.viewModelDidUpdateTomorrowDetails(tomorrowDetails.date, population: tomorrowDetails.population)
        }
    }
    
}

