//
//  SpeciesDetailsViewModel.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import Foundation
import NetworkManager

protocol SpeciesDetailsViewModelDelegate: AnyObject {
    func speciesDetailsFetched(speciesDetails: [SpecieDetails])
    func showError(_ error: Error)
}

final class SpeciesDetailsViewModel {
    
    // MARK: - Class Properties
    let cityIds: [Int]
    var speciesDetails: [SpecieDetails] = []
    weak var delegate: SpeciesDetailsViewModelDelegate?
    
    // MARK: LifeCycles
    init(cityIds: [Int]) {
        self.cityIds = cityIds
    }
    
    func viewDidLoad() {
        guard let id = cityIds.first else { return }
        Task{
            await fetchSpeciesDetails(cityId: id)
        }
    }
    
    // MARK: - Class Methods
    private func fetchSpeciesDetails(cityId: Int) async {
        let urlString = "https://api.inaturalist.org/v1/observations/species_counts?place_id=\(cityId)"
        do {
            let speciesDetailsResponse: SpeciesDetailsResponse = try await NetworkManager.shared.fetchData(fromURL: urlString)
            speciesDetails = speciesDetailsResponse.results
            await MainActor.run{
                delegate?.speciesDetailsFetched(speciesDetails: speciesDetailsResponse.results)
            }
        } catch {
            delegate?.showError(error)
        }
    }
}
