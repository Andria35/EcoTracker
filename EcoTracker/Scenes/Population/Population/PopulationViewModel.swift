//
//  PopulationViewModel.swift
//  EcoTracker
//
//  Created by Nikoloz Gachechiladze on 30.11.23.
//

import Foundation
import NetworkManager

protocol PopulationViewModelDelegate: AnyObject {
    func didFetchCountries(_ countries: CountryResponse)
    func didFetchPopulation(_ population: PopulationData)
    func didTapPopulationButton(_ population: PopulationData)
}

final class PopulationViewModel {
    
    //MARK: - Properties
    
    weak var delegate: PopulationViewModelDelegate?
    var selectedCountry: String = ""
    let countriesURL = "https://d6wn6bmjj722w.population.io/1.0/countries/"
    var countries: CountryResponse = CountryResponse(countries: [])
    var populationData: PopulationData = PopulationData(totalPopulation: [])
    
    
    //MARK: - viewDidLoad
    
    func viewDidLoad() async throws {
        do {
            countries = try await getCountries(url: countriesURL)
        } catch {
            print("Error: \(error)")
        }
    }
    
    //MARK: - Methods
    
    private func getCountries(url: String) async throws -> CountryResponse  {
        do {
            let countries: CountryResponse = try await NetworkManager.shared.fetchData(fromURL: url)
            delegate?.didFetchCountries(countries)
            return countries
        } catch {
            throw error
        }
        
    }
    
    func didTapPopulationButton(country: String) {
            Task {
                do {
                    let populationData: PopulationData = try await getCountriesPopulation(for: country)
                    delegate?.didTapPopulationButton(populationData)
                } catch {
                    print("Error fetching population data: \(error)")
                }
            }
        }
    
    
    func getCountriesPopulation(for country: String) async throws -> PopulationData {
        
        let url = "https://d6wn6bmjj722w.population.io/1.0/population/\(selectedCountry)/today-and-tomorrow/?format=json"
        
        do {
            populationData = try await NetworkManager.shared.fetchData(fromURL: url)
            return populationData
        } catch {
            throw error
        }
        
    }
    
}
