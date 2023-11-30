//
//  SpeciesDetailsTableViewCellViewModel.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import Foundation
import NetworkManager

final class SpeciesDetailsTableViewCellViewModel {
    
    // MARK: - Class Attributes
    weak var delegate: SpeciesDetailsTableViewCellViewModelDelegate?
    // MARK: - Class Methods
    func viewDidLoad() {
    }
    
    func fetchImage(urlString: String) async {
        do {
            let image = try await NetworkManager.shared.fetchImage(fromURL: urlString)
            print(image.size)
            await MainActor.run{
                delegate?.imageFetched(image: image)
            }
        } catch {
            print(error)
        }
    }
}
