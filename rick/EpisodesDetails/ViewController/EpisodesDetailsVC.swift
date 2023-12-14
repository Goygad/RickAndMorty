//
//  EpisodesDetailsVC.swift
//  rick
//
//  Created by Svetlana Arturovnaa on 04.12.2023.
//

import UIKit
import Photos

final class EpisodesDetailsVC: UIViewController {
    
    // MARK: - Private Properties
    private let newPhotoIcon = UIImageView()
    private let characterImageView = UIImageView()
    private let charNameLabel = UILabel()
    private let infoLabel = UILabel()
    private let infoTableView = UITableView()
    private var characterModel: [CharacterModel] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setNavController()
        createCharImage()
        createNewCameraIcon()
        createTableView()
        createInfoLabel()
        createCharName()
        tapGestureCameraIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Functions
    
    func updateId(id: Int) {
        loadCharacters(id: id)
    }
    
    // MARK: - Private functions
    
    private func loadCharacters(id: Int) {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        guard let urlDetails = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else {
            return
        }
        
        session.dataTask(with: urlDetails) { data, response, error in
            DispatchQueue.main.async {
                if error == nil, let data = data {
                    guard let characterPost = try? decoder.decode(CharacterModel.self, from: data) else {
                        return
                    }
                    self.characterModel.append(characterPost)
                    self.infoTableView.reloadData()
                }
            }
        }.resume()
    }
    
    private func loadImage(link: String) {
        DispatchQueue.global().async {
            guard let urlImage = URL(string: "\(link)"),
                  let imageData = try? Data(contentsOf: urlImage) else { return }
            
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    private func setNavController() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.2
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        let icon = UIImageView(image: UIImage(named: "logoShadows"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: icon)
        
        navigationController?.navigationBar.topItem?.backButtonTitle = "GO BACK"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
    }
    
    private func createTableView() {
        
        infoTableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifire)
        infoTableView.backgroundColor = .white
        
        infoTableView.delegate = self
        infoTableView.dataSource = self
        
        view.addSubview(infoTableView)
        
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        infoTableView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 138).isActive = true
        infoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        infoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27).isActive = true
        infoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func createCharImage() {
        
        let hight: CGFloat = 150
        let weight: CGFloat = 150
        
        characterImageView.layer.cornerRadius = CGFloat(hight / 2)
        characterImageView.layer.borderWidth = 3
        characterImageView.layer.masksToBounds = false
        characterImageView.layer.borderColor = CGColor(gray: 0.9, alpha: 1)
        characterImageView.clipsToBounds = true
        view.addSubview(characterImageView)
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.heightAnchor.constraint(equalToConstant: CGFloat(hight)).isActive = true
        characterImageView.widthAnchor.constraint(equalToConstant: CGFloat(weight)).isActive = true
        characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        characterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 124).isActive = true
    }
    
    private func createNewCameraIcon() {
        newPhotoIcon.image = UIImage(named: "Camera")
        view.addSubview(newPhotoIcon)
        
        newPhotoIcon.translatesAutoresizingMaskIntoConstraints = false
        newPhotoIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        newPhotoIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        newPhotoIcon.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 9).isActive = true
        newPhotoIcon.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor).isActive = true
    }
    
    private func tapGestureCameraIcon() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cameraIconTapped))
        newPhotoIcon.isUserInteractionEnabled = true
        newPhotoIcon.addGestureRecognizer(tap)
    }
    
    @objc func cameraIconTapped() {
        showActionSheet()
    }
    
    private func showActionSheet() {
        let imagePicker = UIImagePickerController()
        let actionSheet = UIAlertController(title: "", message: "Загрузить изображение", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { action in
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { action in
            self.phot()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        present(actionSheet, animated: true)
    }
    
    func phot() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in () })
        }
    }
    
    private func createCharName() {
        charNameLabel.textAlignment = .center
        charNameLabel.font = .systemFont(ofSize: 32, weight: .medium)
        view.addSubview(charNameLabel)
        
        charNameLabel.translatesAutoresizingMaskIntoConstraints = false
        charNameLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        charNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 48).isActive = true
        charNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        charNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21).isActive = true
    }
    
    private func createInfoLabel() {
        
        infoLabel.backgroundColor = .white
        infoLabel.text = "Informations"
        infoLabel.textColor = .gray
        infoLabel.font = .systemFont(ofSize: 20, weight: .bold)
        view.addSubview(infoLabel)
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        infoLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 98).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21).isActive = true
    }
}

// MARK: - Extension

extension EpisodesDetailsVC: UITableViewDelegate {
    
}

extension EpisodesDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifire, for: indexPath) as? DetailsTableViewCell
        let model = characterModel[indexPath.row]
        loadImage(link: model.image)
        charNameLabel.text = model.name
        cell?.update(model: model)
        
        return cell ?? UITableViewCell()
    }
}

extension EpisodesDetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        characterImageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}
