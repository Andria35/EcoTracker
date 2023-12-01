//
//  SpeciesDetails.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import UIKit

// MARK: - SpeciesDetailsResponse
struct SpeciesDetailsResponse: Codable {
    let results: [SpecieDetails]
}
 
// MARK: - SpecieDetails
struct SpecieDetails: Codable {
    let taxon: SpecieAttributes
}
 
// MARK: - SpecieAttributes
struct SpecieAttributes: Codable {
    let name: String
    let defaultPhoto: DefaultPhoto
    let wikipediaUrl: String?
}
 
// MARK: - DefaultPhoto
struct DefaultPhoto: Codable {
    let attribution: String
    let url: String
}
