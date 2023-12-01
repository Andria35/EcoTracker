//
//  SpeciesDetails.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import UIKit

// MARK: - SpeciesDetailsResponse
struct SpeciesDetailsResponse: Decodable {
    let results: [SpecieDetails]
}
 
// MARK: - SpecieDetails
struct SpecieDetails: Decodable {
    let taxon: SpecieAttributes
}
 
// MARK: - SpecieAttributes
struct SpecieAttributes: Decodable {
    let name: String
    let defaultPhoto: DefaultPhoto
    let wikipediaUrl: String?
}
 
// MARK: - DefaultPhoto
struct DefaultPhoto: Decodable {
    let attribution: String
    let url: String
}
