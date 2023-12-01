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
    func viewDidLoad(urlString: String, authorString: String) {
        Task {
            await fetchImage(urlString: urlString)
        }
        let parsedAuthorString = parseAuthor(author: authorString)
        delegate?.authorParsed(parsedAuthorString: parsedAuthorString)
    }
    
    private func fetchImage(urlString: String) async {
        do {
            let image = try await NetworkManager.shared.fetchImage(fromURL: urlString)
            await MainActor.run{
                delegate?.imageFetched(image: image)
            }
        } catch {
            print(error)
        }
    }
    
    private func parseAuthor(author: String) -> String {
        var extractedName = "No Author Found"
        do {
            let regex = try NSRegularExpression(pattern: "\\(c\\) (.+?),", options: [])
            let matches = regex.matches(in: author, options: [], range: NSRange(location: 0, length: author.utf16.count))

            if let match = matches.first {
                let range = Range(match.range(at: 1), in: author)!
                extractedName = String(author[range])
            }
        } catch {
            print("Error while parsing: \(error)")
        }
        return extractedName
    }
}
