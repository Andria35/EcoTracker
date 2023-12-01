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
}
