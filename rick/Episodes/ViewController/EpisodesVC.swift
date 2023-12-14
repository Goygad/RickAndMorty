//
//  EpisodesVC.swift
//  rick
//
//  Created by Svetlana Arturovnaa on 04.12.2023.
//

import UIKit

final class EpisodesVC: UIViewController {
    
    // MARK: - Private Properties
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let imageRickLogo = UIImageView()
    private let searchBar = UISearchBar()
    private let filtersButton = UIButton()
    private var detailModel: [DetailPostModel] = []
    private var characterModel: [CharacterModel] = []
    private var searchData: [DetailPostModel] = []
    private var characterModelDict: [Int: CharacterModel] = [:]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadEpisodes()
        createLogo()
        createSearchBar()
        createFiltersButton()
        createCollectionView()
        searchData = detailModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private functions
    
    private func loadEpisodes() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil, let data = data else { return }
            
            do {
                let posts = try JSONDecoder().decode(EpisodesModel.self, from: data)
                self.detailModel = posts.results
                
                for post in posts.results {
                    self.loadCharacters(id: post.id)
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("Error decoding episodes: \(error)")
            }
        }.resume()
    }
    
    private func loadCharacters(id: Int) {
        guard let urlDetails = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else { return }
        
        URLSession.shared.dataTask(with: urlDetails) { [weak self] data, response, error in
            guard let self = self, error == nil, let data = data else { return }
            
            do {
                let characterPost = try JSONDecoder().decode(CharacterModel.self, from: data)
                characterModel.append(characterPost)
                self.characterModelDict[id] = characterPost
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("Error decoding character: \(error)")
            }
        }.resume()
    }
    
    private func createLogo() {
        imageRickLogo.image = UIImage(named: "rickLogo")
        view.addSubview(imageRickLogo)
        
        imageRickLogo.translatesAutoresizingMaskIntoConstraints = false
        imageRickLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 57).isActive = true
        imageRickLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        imageRickLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22).isActive = true
    }
    
    private func createSearchBar() {
        searchBar.placeholder = "Name of episode (ex.S01.E01)"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = .init(gray: 5, alpha: 1)
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: imageRickLogo.bottomAnchor, constant: 67).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22).isActive = true
    }
    
    private func createFiltersButton() {
        filtersButton.backgroundColor = UIColor(red: 0.4627, green: 0.8, blue: 1, alpha: 1)
        filtersButton.setTitle("ADVANCED FILTERS", for: .normal)
        filtersButton.setTitleColor(.systemBlue, for: .normal)
        filtersButton.layer.cornerRadius = 8
        filtersButton.titleLabel?.font = .systemFont(ofSize: 18)
        filtersButton.layer.shadowRadius = 2
        filtersButton.layer.shadowColor = UIColor.gray.cgColor
        filtersButton.layer.shadowOpacity = 1
        filtersButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.addSubview(filtersButton)
        
        filtersButton.translatesAutoresizingMaskIntoConstraints = false
        filtersButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12).isActive = true
        filtersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        filtersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
    private func createCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EpisodesViewCell.self, forCellWithReuseIdentifier: EpisodesViewCell.identifire)
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: filtersButton.bottomAnchor, constant: 30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

// MARK: - Extension

extension EpisodesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesViewCell.identifire, for: indexPath) as? EpisodesViewCell else {
            return UICollectionViewCell()
        }
        
        var episodeModel: DetailPostModel
        var characterModel: CharacterModel
        
        if searchData.count != 0, indexPath.row < searchData.count {
            episodeModel = searchData[indexPath.row]
            let id = episodeModel.id
            
            if let charModel = characterModelDict[id] {
                characterModel = charModel
            } else {
                return cell
            }
            
        } else if indexPath.row < detailModel.count {
            episodeModel = detailModel[indexPath.row]
            
            if indexPath.row < self.characterModel.count {
                characterModel = self.characterModel[indexPath.row]
            } else {
                return cell
            }
        } else {
            return cell
        }
        
        cell.update(model: episodeModel, charModel: characterModel)
        
        return cell
    }
}

extension EpisodesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < characterModel.count else { return }
        
        let char = characterModel[indexPath.row]
        let vcDetail = EpisodesDetailsVC()
        vcDetail.updateId(id: char.id)
        navigationController?.pushViewController(vcDetail, animated: true)
    }
}

extension EpisodesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 311, height: 357)
        
        return size
    }
}

extension EpisodesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchData = searchText.isEmpty ? detailModel : detailModel.filter { episode in
            return episode.episode.lowercased().contains(searchText.lowercased())
        }
        
        characterModel = searchData.compactMap { episode in
            let id = episode.id
            return characterModelDict[id]
        }
        
        collectionView.reloadData()
    }
}
