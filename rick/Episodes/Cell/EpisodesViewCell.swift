//
//  EpisodesViewCell.swift
//  rick
//
//  Created by Svetlana Arturovnaa on 05.12.2023.
//

import UIKit

final class EpisodesViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifire = "EpisodesViewCell"
    
    // MARK: - Private Properties
    
    private let cardView = UIView()
    private let episodeImageView = UIImageView()
    private let nameView = UIView()
    private let nameLabel = UILabel()
    private let episodeBarView = UIView()
    private let episodeLabel = UILabel()
    private let playIconView = UIImageView()
    private let heartIconView = UIImageView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCardView()
        createImageView()
        createNameView()
        createNameLabel()
        createEpisodeBarView()
        createPlayIconView()
        createEpisodeLabel()
        createHeartIconView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func update(model: DetailPostModel, charModel: CharacterModel) {
        nameLabel.text = charModel.name
        episodeLabel.text = "\(model.name) | \(model.episode)"
        
        DispatchQueue.global().async {
            let constImage = charModel.image
            guard let urlImage = URL(string: "\(constImage)"),
                  let imageData = try? Data(contentsOf: urlImage) else { return }
            
            DispatchQueue.main.async {
                self.episodeImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: - Private functions
    
    private func createCardView() {
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowRadius = 2
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -55).isActive = true
    }
    
    private func createImageView() {
        episodeImageView.contentMode = .scaleAspectFit
        cardView.addSubview(episodeImageView)
        
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        episodeImageView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        episodeImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        episodeImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
    }
    
    private func createNameView() {
        nameView.backgroundColor = .white
        cardView.addSubview(nameView)
        
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.topAnchor.constraint(equalTo: episodeImageView.bottomAnchor).isActive = true
        nameView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        nameView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
    }
    
    private func createNameLabel() {
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 12).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -16).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -12).isActive = true
    }
    
    private func createEpisodeBarView() {
        episodeBarView.backgroundColor = .systemGray6
        episodeBarView.layer.cornerRadius = 8
        cardView.addSubview(episodeBarView)
        
        episodeBarView.translatesAutoresizingMaskIntoConstraints = false
        episodeBarView.topAnchor.constraint(equalTo: nameView.bottomAnchor).isActive = true
        episodeBarView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        episodeBarView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        episodeBarView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
    }
    
    private func createPlayIconView() {
        episodeBarView.addSubview(playIconView)
        playIconView.image = UIImage(named: "MonitorPlay")
        
        playIconView.translatesAutoresizingMaskIntoConstraints = false
        playIconView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        playIconView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        playIconView.topAnchor.constraint(equalTo: episodeBarView.topAnchor, constant: 22).isActive = true
        playIconView.leadingAnchor.constraint(equalTo: episodeBarView.leadingAnchor, constant: 22).isActive = true
    }
    
    private func createEpisodeLabel() {
        episodeLabel.numberOfLines = 0
        episodeBarView.addSubview(episodeLabel)
        
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeLabel.topAnchor.constraint(equalTo: episodeBarView.topAnchor, constant: 28).isActive = true
        episodeLabel.leadingAnchor.constraint(equalTo: playIconView.trailingAnchor, constant: 11).isActive = true
        episodeLabel.bottomAnchor.constraint(equalTo: episodeBarView.bottomAnchor, constant: -20).isActive = true
    }
    
    private func createHeartIconView() {
        heartIconView.image = UIImage(named: "HeartBar")
        episodeBarView.addSubview(heartIconView)
        
        heartIconView.translatesAutoresizingMaskIntoConstraints = false
        heartIconView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        heartIconView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        heartIconView.topAnchor.constraint(equalTo: episodeBarView.topAnchor, constant: 17).isActive = true
        heartIconView.trailingAnchor.constraint(equalTo: episodeBarView.trailingAnchor, constant: -18).isActive = true
        episodeLabel.trailingAnchor.constraint(equalTo: heartIconView.leadingAnchor, constant: -11).isActive = true
    }
}
