//
//  FilmDetailViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Core
import SwiftUI

@MainActor
final class FilmDetailViewModel: BaseDetailViewModel {
    private let film: Film
    
    init(
        film: Film,
        peopleRepository: PeopleRepositoryProtocol,
        planetsRepository: PlanetsRepositoryProtocol,
        starshipsRepository: StarshipsRepositoryProtocol,
        vehiclesRepository: VehiclesRepositoryProtocol,
        speciesRepository: SpeciesRepositoryProtocol
    ) {
        self.film = film
        super.init()
        
        self.peopleRepository = peopleRepository
        self.planetsRepository = planetsRepository
        self.starshipsRepository = starshipsRepository
        self.vehiclesRepository = vehiclesRepository
        self.speciesRepository = speciesRepository
        
        self.peopleURLs = film.characters
        self.planetsURLs = film.planets
        self.starshipsURLs = film.starships
        self.vehiclesURLs = film.vehicles
        self.speciesURLs = film.species
        
        if !film.characters.isEmpty { self.supportedRelatedTypes.append(.person) }
        if !film.planets.isEmpty { self.supportedRelatedTypes.append(.planet) }
        if !film.starships.isEmpty { self.supportedRelatedTypes.append(.starship) }
        if !film.vehicles.isEmpty { self.supportedRelatedTypes.append(.vehicle) }
        if !film.species.isEmpty { self.supportedRelatedTypes.append(.species) }
    }
}

// MARK: - Properties
extension FilmDetailViewModel {
    var title: String { film.title }
    var episodeId: Int { film.episodeId }
    var director: String { film.director }
    var producer: String { film.producer }
    var releaseDate: String { film.releaseDate }
    var openingCrawl: String { film.openingCrawl }

	var filmCharacters: [Person] { relatedPeople }
	var filmPlanets: [Planet] { relatedPlanets }
	var filmStarships: [Starship] { relatedStarships }
	var filmVehicles: [Vehicle] { relatedVehicles }
	var filmSpecies: [Species] { relatedSpecies }
}
