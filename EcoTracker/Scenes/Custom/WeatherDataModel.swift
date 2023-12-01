//
//  WeatherDataModel.swift
//  EcoTracker
//
//  Created by Sofo Machurishvili on 30.11.23.
//

import Foundation

struct WeatherDataModel: Decodable {
    var weather: [WeatherModel] = []
    let main: MainModel
    let name: String
    
}
