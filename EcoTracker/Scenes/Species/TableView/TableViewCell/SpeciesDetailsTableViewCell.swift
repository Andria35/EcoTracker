//
//  SpeciesDetailsTableViewCell.swift
//  EcoTracker
//
//  Created by Andria Inasaridze on 30.11.23.
//

import UIKit

protocol SpeciesDetailsTableViewCellViewModelDelegate: AnyObject {
    func imageFetched(image: UIImage)
    func authorParsed(parsedAuthorString: String)
}

final class SpeciesDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Class Properties
    static let cellId = "SpeciesDetailsCell"
    private let viewModel = SpeciesDetailsTableViewCellViewModel()
    
    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.spacing = 2
        return stackView
    }()
    
    private let mainImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.image = UIImage(systemName: "photo.artframe")
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        label.text = "Name"
        label.textColor = .textColor
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.text = "Author..."
        label.textColor = .textColor.withAlphaComponent(0.7)
        label.numberOfLines = 0
        return label
    }()
    
    private let linkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 12)
        label.text = "Link..."
        label.textColor = .textColor.withAlphaComponent(0.5)
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        setupConstraints()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        authorLabel.text = nil
        linkLabel.text = nil
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupBackground()
        setupSubviews()
        setupLinkLabel()
    }
    
    private func setupBackground() {
        backgroundColor = UIColor.backgroundColor
    }
    
    private func setupSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainImageView)
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(authorLabel)
        textStackView.addArrangedSubview(linkLabel)
        mainStackView.addArrangedSubview(textStackView)
    }
    
    private func setupLinkLabel() {
        linkLabel.attributedText = NSAttributedString(string: linkLabel.text ?? "", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        setupMainHStackConstraints()
        setupNoteImageViewConstraints()
    }
    
    private func setupMainHStackConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
    }
    
    private func setupNoteImageViewConstraints() {
        mainImageView.heightAnchor.constraint(equalToConstant: self.frame.width * 0.2).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.2).isActive = true
    }
    
    // MARK: Setup Delegates
    private func setupDelegates() {
        viewModel.delegate = self
    }
    
    // MARK: - Class Methods
    func configure(with specieDetails: SpecieDetails) {
        nameLabel.text = specieDetails.taxon.name
        let authorString = specieDetails.taxon.defaultPhoto.attribution
        linkLabel.text = specieDetails.taxon.wikipediaUrl
        viewModel.viewDidLoad(urlString: specieDetails.taxon.defaultPhoto.url, authorString: authorString)
    }
}

// MARK: - SpeciesDetailsTableViewCellViewModelDelegate
extension SpeciesDetailsTableViewCell: SpeciesDetailsTableViewCellViewModelDelegate {
    
    func imageFetched(image: UIImage) {
        mainImageView.image = image
    }
    
    func authorParsed(parsedAuthorString: String) {
        authorLabel.text = parsedAuthorString
    }
}
