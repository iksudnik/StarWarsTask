//
//  StarshipDTO.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

struct StarshipDTO: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let maxAtmospheringSpeed: String
    let crew: String
    let passengers: String
    let cargoCapacity: String
    let consumables: String
    let hyperdriveRating: String
    let MGLT: String
    let starshipClass: String
    let pilots: [String]
    let films: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer, length, crew, passengers, consumables, MGLT, pilots, films, url
        case costInCredits = "cost_in_credits"
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case cargoCapacity = "cargo_capacity"
        case hyperdriveRating = "hyperdrive_rating"
        case starshipClass = "starship_class"
    }
} 