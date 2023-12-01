//
//  SpeciesCity.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import Foundation

// MARK: - SpeciesCityResponse
struct SpeciesCityResponse: Decodable {
    let results: [SpeciesCity]
}

// MARK: - SpeciesCity
struct SpeciesCity: Decodable {
    let id: Int
}
