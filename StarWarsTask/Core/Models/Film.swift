//
//  Film.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

struct Film: Identifiable, Codable, Hashable {
    let id = UUID()
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let characters: [String]
    let planets: [String]
    let starships: [String]
    let vehicles: [String]
    let species: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title, director, producer, characters, planets, starships, vehicles, species, url
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case releaseDate = "release_date"
    }
}
