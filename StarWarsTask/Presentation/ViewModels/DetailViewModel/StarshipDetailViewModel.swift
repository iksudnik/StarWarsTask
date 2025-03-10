//
//  StarshipDetailViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

@MainActor
final class StarshipDetailViewModel: BaseDetailViewModel {
    private let starship: Starship
    
    init(
        starship: Starship,
        peopleRepository: PeopleRepositoryProtocol,
        filmsRepository: FilmsRepositoryProtocol
    ) {
        self.starship = starship
        super.init()
        
        self.peopleRepository = peopleRepository
        self.filmsRepository = filmsRepository
        
        self.peopleURLs = starship.pilots
        self.filmsURLs = starship.films
        
        if !starship.pilots.isEmpty { self.supportedRelatedTypes.append(.person) }
        if !starship.films.isEmpty { self.supportedRelatedTypes.append(.film) }
    }
}

// MARK: - Properties
extension StarshipDetailViewModel {
    var name: String { starship.name }
    var model: String { starship.model }
    var manufacturer: String { starship.manufacturer }
    var starshipClass: String { starship.starshipClass }
    var costInCredits: String { starship.costInCredits }
    var length: String { starship.length }
    var crew: String { starship.crew }
    var passengers: String { starship.passengers }
    var maxAtmospheringSpeed: String { starship.maxAtmospheringSpeed }
    var hyperdriveRating: String { starship.hyperdriveRating }
    var MGLT: String { starship.MGLT }
    var cargoCapacity: String { starship.cargoCapacity }
    var consumables: String { starship.consumables }
    
    var starshipPilots: [Person] { relatedPeople }
    var starshipFilms: [Film] { relatedFilms }
}
