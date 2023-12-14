//
//  CharacterModel.swift
//  rick
//
//  Created by Svetlana Arturovnaa on 07.12.2023.
//

import Foundation

struct CharacterModel: Codable {
    
    // MARK: - Properties

    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    
    // MARK: - Properties
    
    let name: String
    let url: String
}
