//
//  PersonDetailViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

@MainActor
final class PersonDetailViewModel: BaseDetailViewModel {
    private let person: Person
    
    init(
        person: Person,
        peopleRepository: PeopleRepositoryProtocol,
        planetsRepository: PlanetsRepositoryProtocol,
        starshipsRepository: StarshipsRepositoryProtocol,
        vehiclesRepository: VehiclesRepositoryProtocol,
        speciesRepository: SpeciesRepositoryProtocol,
        filmsRepository: FilmsRepositoryProtocol
    ) {
        self.person = person
        super.init()

        self.peopleRepository = peopleRepository
        self.planetsRepository = planetsRepository
        self.starshipsRepository = starshipsRepository
        self.vehiclesRepository = vehiclesRepository
        self.speciesRepository = speciesRepository
        self.filmsRepository = filmsRepository
        
        if !person.homeworld.isEmpty {
            self.planetsURLs = [person.homeworld]
            self.supportedRelatedTypes.append(.planet)
        }
        
        self.starshipsURLs = person.starships
        self.vehiclesURLs = person.vehicles
        self.filmsURLs = person.films
        self.speciesURLs = person.species

        if !person.starships.isEmpty { self.supportedRelatedTypes.append(.starship) }
        if !person.vehicles.isEmpty { self.supportedRelatedTypes.append(.vehicle) }
        if !person.films.isEmpty { self.supportedRelatedTypes.append(.film) }
        if !person.species.isEmpty { self.supportedRelatedTypes.append(.species) }
    }
}

// MARK: - Properties
extension PersonDetailViewModel {
    var name: String { person.name }
    var gender: String { person.gender }
    var birthYear: String { person.birthYear }
    var height: String { person.height }
    var mass: String { person.mass }
    var hairColor: String { person.hairColor }
    var skinColor: String { person.skinColor }
    var eyeColor: String { person.eyeColor }

    var personStarships: [Starship] { relatedStarships }
    var personVehicles: [Vehicle] { relatedVehicles }
    var personFilms: [Film] { relatedFilms }
    var personSpecies: [Species] { relatedSpecies }
    var homeworld: Planet? { relatedPlanets.first }
}
