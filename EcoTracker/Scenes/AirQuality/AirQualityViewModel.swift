//
//  AirQualityViewModel.swift
//  EcoTracker
//
//  Created by Ani's Mac on 30.11.23.
//

import Foundation
import NetworkManager

protocol AirQualityViewModelDelegate: AnyObject {
    func navigateToDetailsPage(with city: String)
    func cityFetched(_ city: DataClass)
    func showError(_ error: Error)
}

final class AirQualityViewModel {
    
    weak var delegate: AirQualityViewModelDelegate?
    
    func checkAirQualityButtonDidTap(text: String) async {
        guard !text.isEmpty else {
            print("Please, Provide Information")
            return
        }
        await fetchCity(for: text)
    }
    
    private func fetchCity(for cityName: String) async {
        Task {
            do {
                let urlString = "https://api.airvisual.com/v2/city?city=\(cityName)&state=California&country=USA&key=b0746aa7-b11e-47d8-abff-138500378c24"
                let fetchedCity: AirQualityModel = try await NetworkManager.shared.fetchData(fromURL: urlString)
                await MainActor.run {
                    self.delegate?.cityFetched(fetchedCity.data)
                    self.delegate?.navigateToDetailsPage(with: cityName)
                }
            } catch {
                self.delegate?.showError(error)
            }
        }
    }
}

/*
 ლინკს მოაქვს ინფორმაცია მხოლოდ კალიფორნიის შტატის ქალაქებზე:
 Los Angeles, San Francisco, San Jose,  Anaheim,, Riverside...
 */
