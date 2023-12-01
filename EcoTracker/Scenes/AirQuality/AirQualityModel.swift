//
//  AirQualityModel.swift
//  EcoTracker
//
//  Created by Ani's Mac on 30.11.23.
//
import Foundation

// MARK: - AirQualityModel
struct AirQualityModel: Decodable {
    let status: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let city: String
    let current: Current
}

// MARK: - Current
struct Current: Decodable {
    let pollution: Pollution
}

// MARK: - Pollution
struct Pollution: Decodable {
    let ts: String
    let aqius: Int
    let mainus: String
    let aqicn: Int
    let maincn: String
}




