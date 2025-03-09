//
//  APIEndpoint.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

enum APIEndpoint {
    case people
    case planets
    case starships
    case vehicles
    case species
    case films
    case personDetail(id: Int)
    case planetDetail(id: Int)
    case starshipDetail(id: Int)
    case vehicleDetail(id: Int)
    case speciesDetail(id: Int)
    case filmDetail(id: Int)
    
    var urlString: String {
        let baseURL = "https://swapi.dev/api"
        
        switch self {
        case .people:
            return "\(baseURL)/people/"
        case .planets:
            return "\(baseURL)/planets/"
        case .starships:
            return "\(baseURL)/starships/"
        case .vehicles:
            return "\(baseURL)/vehicles/"
        case .species:
            return "\(baseURL)/species/"
        case .films:
            return "\(baseURL)/films/"
        case .personDetail(let id):
            return "\(baseURL)/people/\(id)/"
        case .planetDetail(let id):
            return "\(baseURL)/planets/\(id)/"
        case .starshipDetail(let id):
            return "\(baseURL)/starships/\(id)/"
        case .vehicleDetail(let id):
            return "\(baseURL)/vehicles/\(id)/"
        case .speciesDetail(let id):
            return "\(baseURL)/species/\(id)/"
        case .filmDetail(let id):
            return "\(baseURL)/films/\(id)/"
        }
    }
}
