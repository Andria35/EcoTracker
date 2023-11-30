//
//  CountriesModel.swift
//  EcoTracker
//
//  Created by Nikoloz Gachechiladze on 30.11.23.
//

import Foundation

struct CountryResponse: Decodable {
    let countries: [String]
}

struct PopulationData: Decodable {
    let totalPopulation: [PopulationInfo]
}

struct PopulationInfo: Decodable {
    let date: String
    let population: Int
}

