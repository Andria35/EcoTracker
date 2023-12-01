//
//  AirQualityDetailsViewModel.swift
//  EcoTracker
//
//  Created by Ani's Mac on 30.11.23.
//

import Foundation
import NetworkManager

protocol AirQualityDetailsViewModelDelegate: AnyObject {
    func airQualityDataFetched(_ airQualityData: AirQualityModel)
    func showError(_ error: Error)
}

final class AirQualityDetailsViewModel {
    weak var delegate: AirQualityDetailsViewModelDelegate?
    
    func fetchAirQualityData(for cityName: String) {
        Task {
            do {
                let urlString = "https://api.airvisual.com/v2/city?city=\(cityName)&state=California&country=USA&key=b0746aa7-b11e-47d8-abff-138500378c24"
                let airQualityData: AirQualityModel = try await NetworkManager.shared.fetchData(fromURL: urlString)
                await MainActor.run {
                    self.delegate?.airQualityDataFetched(airQualityData)
                }
            } catch {
                self.delegate?.showError(error)
            }
        }
    }
    
    func airQualityDescription(forAQI aqius: Int) -> String {
        let description: String
            switch aqius {
            case 0...50:
                description = "Air quality is great, no significant health risk. Enjoy outdoor activities!"
            case 51...100:
                description = "Air quality is acceptable; however, there may be some concern for very sensitive individuals. Unusually sensitive people should consider limiting prolonged outdoor exertion."
            case 101...150:
                description = "Members of sensitive groups may experience health effects. The general public is less likely to be affected."
            case 151...200:
                description = "Everyone may begin to experience adverse health effects, and members of sensitive groups may experience more serious effects. Avoid prolonged outdoor exertion; everyone else, especially children, should limit outdoor exertion."
            case 201...250:
                description = "Health alert: everyone may experience more serious health effects. Everyone should avoid outdoor activities, and members of sensitive groups should avoid all outdoor exertion."
            case 251...300:
                description = "Health warnings of emergency conditions. The entire population is likely to be affected. Avoid all outdoor activities, and remain indoors as much as possible."
            case 301...500:
                description = "Health alert: everyone may experience more serious health effects. The health warnings of emergency conditions; the entire population is more likely to be affected."
            default:
                description = "Air quality information not available."
            }
        
        return description
        }
    }

