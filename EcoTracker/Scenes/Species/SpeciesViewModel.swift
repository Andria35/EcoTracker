//
//  SpeciesViewModel.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import Foundation
import NetworkManager

protocol SpeciesViewModelDelegate: AnyObject {
    func cityIdsFetched(_ cityIds: [SpeciesCity])
    func cityIdsNotFetched() // this method is called when user inputs invalid city name
    func showError(_ error: Error)
}

final class SpeciesViewModel {
    
    // MARK: - Class Properties
    weak var delegate: SpeciesViewModelDelegate?
    private var cityIds: [SpeciesCity] = []
    
    
    //MARK: - Class Methods
    func viewDidLoad() {
        
    }
    
    func fetchCityId(by cityName: String) async {
        let urlString = "https://api.inaturalist.org/v1/places/autocomplete?q=\(cityName)"
        do {
            let speciesCityResponse: SpeciesCityResponse = try await NetworkManager.shared.fetchData(fromURL: urlString)
            cityIds = speciesCityResponse.results
            await MainActor.run{
                checkCityIds()
            }
        } catch {
            delegate?.showError(error)
        }
    }
    
    private func checkCityIds() {
        if cityIds.isEmpty {
            delegate?.cityIdsNotFetched()
        } else {
            delegate?.cityIdsFetched(cityIds)
        }
    }

}
