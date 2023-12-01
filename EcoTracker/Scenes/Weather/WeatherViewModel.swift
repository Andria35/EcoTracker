//
//  WeatherViewModel.swift
//  EcoTracker
//
//  Created by Sofo Machurishvili on 30.11.23.
//

import NetworkManager

protocol DataFetchDelegate {
    func fetchCompleted() async
    func fetchFailed(error: Error) async
}

class WeatherViewModel {
    private let endpoint = "https://api.openweathermap.org/data/2.5/weather"
    private let appId = "86be04ecd19df7742b46fe3f67bb2ba4"
    
    
    var weatherInfo: WeatherDataModel? = nil
    var delegate: DataFetchDelegate? = nil
    
    func fetchData(long: String, lat: String, cityName: String) {
        if cityName == "" && (long == "" || lat == "") {
            print("Please enter correct info")
        } else {
            Task {
                do {
                    let urlString = buildURL(long: long, lat: lat, cityName: cityName)
                    
                    if let weatherFetchModel: WeatherDataModel = try await NetworkManager.shared.fetchData(fromURL: urlString) {
                        weatherInfo = weatherFetchModel
                        await delegate?.fetchCompleted()
                    }
                } catch {
                    await delegate?.fetchFailed(error: error)
                }
            }
        }
    }
    
    private func buildURL(long: String, lat: String, cityName: String) -> String {
        var queryParams: [String] = []
        
        if cityName != "" {
            queryParams.append("q=\(cityName)")
        } else if long != "" && lat != "" {
            queryParams.append("lon=\(long)&lat=\(lat)")
        }
        
        queryParams.append("units=metric")
        queryParams.append("appid=\(appId)")
        
        let queryString = queryParams.joined(separator: "&")
        
        return "\(endpoint)?\(queryString)"
    }
}

