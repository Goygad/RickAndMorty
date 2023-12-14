//
//  DetailsTableViewCell.swift
//  rick
//
//  Created by Svetlana Arturovnaa on 05.12.2023.
//

import UIKit

final class DetailsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifire = "detailsCell"
    
    // MARK: - Private Properties
    
    private let separatorGender = UIView()
    private let separatorStatus = UIView()
    private let separatorSpeice = UIView()
    private let separatorOrigin = UIView()
    private let separatorType = UIView()
    
    private let genderLabel = UILabel()
    private let genderSubLabel = UILabel()
    
    private let statusLabel = UILabel()
    private let statusSubLabel = UILabel()
    
    private let speiceLabel = UILabel()
    private let speiceSubLabel = UILabel()
    
    private let originLabel = UILabel()
    private let originSubLabel = UILabel()
    
    private let typeLabel = UILabel()
    private let typeSubLabel = UILabel()
    
    private let locationLabel = UILabel()
    private let locationSubLabel = UILabel()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 9, left: 16, bottom: 12, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        
        setInfoLabels()
        setSeparators()
        setStackView()
        setInfoSubLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func update(model: CharacterModel) {
        genderSubLabel.text = model.gender
        statusSubLabel.text = model.status
        speiceSubLabel.text = model.species
        originSubLabel.text = model.origin.name
        typeSubLabel.text = model.type
        locationSubLabel.text = model.location.name
    }
    
    // MARK: - Private functions
    
    private func setInfoLabels() {
        genderLabel.text = "Gender"
        genderLabel.font = .systemFont(ofSize: 16, weight: .bold)
        statusLabel.text = "Status"
        statusLabel.font = .systemFont(ofSize: 16, weight: .bold)
        speiceLabel.text = "Speice"
        speiceLabel.font = .systemFont(ofSize: 16, weight: .bold)
        originLabel.text = "Origin"
        originLabel.font = .systemFont(ofSize: 16, weight: .bold)
        typeLabel.text = "Type"
        typeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        locationLabel.text = "Location"
        locationLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    private func setInfoSubLabels() {
        genderSubLabel.font = .systemFont(ofSize: 14, weight: .medium)
        genderSubLabel.textColor = .gray
        statusSubLabel.font = .systemFont(ofSize: 14, weight: .medium)
        statusSubLabel.textColor = .gray
        speiceSubLabel.font = .systemFont(ofSize: 14, weight: .medium)
        speiceSubLabel.textColor = .gray
        originSubLabel.font = .systemFont(ofSize: 14, weight: .medium)
        originSubLabel.textColor = .gray
        typeSubLabel.font = .systemFont(ofSize: 14, weight: .medium)
        typeSubLabel.textColor = .gray
        locationSubLabel.font = .systemFont(ofSize: 14, weight: .medium)
        locationSubLabel.textColor = .gray
    }
    
    private func setSeparators() {
        separatorGender.backgroundColor = .systemGray5
        separatorGender.translatesAutoresizingMaskIntoConstraints = false
        separatorGender.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        separatorStatus.backgroundColor = .systemGray5
        separatorStatus.translatesAutoresizingMaskIntoConstraints = false
        separatorStatus.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        separatorSpeice.backgroundColor = .systemGray5
        separatorSpeice.translatesAutoresizingMaskIntoConstraints = false
        separatorSpeice.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        separatorOrigin.backgroundColor = .systemGray5
        separatorOrigin.translatesAutoresizingMaskIntoConstraints = false
        separatorOrigin.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        separatorType.backgroundColor = .systemGray5
        separatorType.translatesAutoresizingMaskIntoConstraints = false
        separatorType.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setStackView() {
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(genderSubLabel)
        stackView.setCustomSpacing(11, after: genderSubLabel)
        stackView.setCustomSpacing(6, after: genderLabel)
        stackView.addArrangedSubview(separatorGender)
        stackView.setCustomSpacing(9, after: separatorGender)
        
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(statusSubLabel)
        stackView.setCustomSpacing(11, after: statusSubLabel)
        stackView.setCustomSpacing(6, after: statusLabel)
        stackView.addArrangedSubview(separatorStatus)
        stackView.setCustomSpacing(9, after: separatorStatus)
        
        stackView.addArrangedSubview(speiceLabel)
        stackView.addArrangedSubview(speiceSubLabel)
        stackView.setCustomSpacing(11, after: speiceSubLabel)
        stackView.setCustomSpacing(6, after: speiceLabel)
        stackView.addArrangedSubview(separatorSpeice)
        stackView.setCustomSpacing(9, after: separatorSpeice)
        
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(originSubLabel)
        stackView.setCustomSpacing(11, after: originSubLabel)
        stackView.setCustomSpacing(6, after: originLabel)
        stackView.addArrangedSubview(separatorOrigin)
        stackView.setCustomSpacing(9, after: separatorOrigin)
        
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(typeSubLabel)
        stackView.setCustomSpacing(11, after: typeSubLabel)
        stackView.setCustomSpacing(6, after: typeLabel)
        stackView.addArrangedSubview(separatorType)
        stackView.setCustomSpacing(9, after: separatorType)
        
        stackView.addArrangedSubview(locationLabel)
        stackView.setCustomSpacing(6, after: locationLabel)
        stackView.addArrangedSubview(locationSubLabel)
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
