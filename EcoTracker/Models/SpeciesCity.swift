//
//  SpeciesCity.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import Foundation

// MARK: - CityResponce
struct SpeciesCityResponce: Codable {
    let results: [SpeciesCity]
}

// MARK: - Result
struct SpeciesCity: Codable {
    let id: Int
}
