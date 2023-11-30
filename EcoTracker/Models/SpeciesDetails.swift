//
//  SpeciesDetails.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import Foundation

// MARK: - CityDetailsResponse
struct SpeciesDetailsResponse: Decodable {
    let results: [SpecieDetails]
}

// MARK: - Result
struct SpecieDetails: Decodable {
    let taxon: SpecieAttributes
   }

// MARK: - Taxon
struct SpecieAttributes: Decodable {
    let name: String
    let defaultPhoto: DefaultPhoto?
    let wikipediaURL: String?
//
    enum CodingKeys: String, CodingKey {
        case name
        case defaultPhoto = "default_photo"
        case wikipediaURL = "wikipedia_url"
    }
}

// MARK: - DefaultPhoto
struct DefaultPhoto: Decodable {
    let attribution: String
    let url: String
    let squareURL, mediumURL: String

    enum CodingKeys: String, CodingKey {
        case attribution, url
        case squareURL = "square_url"
        case mediumURL = "medium_url"
    }
}
