//
//  DetailPostModel.swift
//  rick
//
//  Created by Svetlana Arturovnaa on 07.12.2023.
//

import Foundation

struct DetailPostModel: Codable {
    
    // MARK: - Properties
    
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
