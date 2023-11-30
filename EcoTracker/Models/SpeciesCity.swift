//
//  SpeciesCity.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import Foundation

// MARK: - CityResponce
struct SpeciesCityResponse: Decodable {
    let results: [SpeciesCity]
}

// MARK: - Result
struct SpeciesCity: Decodable {
    let id: Int
}
