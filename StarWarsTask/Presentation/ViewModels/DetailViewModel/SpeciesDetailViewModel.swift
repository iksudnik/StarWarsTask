//
//  SpeciesDetailViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

@MainActor
class SpeciesDetailViewModel: BaseDetailViewModel {
    private let species: Species
    
    init(
        species: Species,
        peopleRepository: PeopleRepositoryProtocol,
        planetsRepository: PlanetsRepositoryProtocol,
        filmsRepository: FilmsRepositoryProtocol
    ) {
        self.species = species
        super.init()
        
        self.peopleRepository = peopleRepository
        self.planetsRepository = planetsRepository
        self.filmsRepository = filmsRepository
        
        if let homeworldURL = species.homeworld, !homeworldURL.isEmpty {
            self.planetsURLs = [homeworldURL]
            self.supportedRelatedTypes.append(.planet)
        }
        
        self.peopleURLs = species.people
        self.filmsURLs = species.films
        
        if !species.people.isEmpty { self.supportedRelatedTypes.append(.person) }
        if !species.films.isEmpty { self.supportedRelatedTypes.append(.film) }
    }
}

// MARK: - Properties
extension SpeciesDetailViewModel {
    var name: String { species.name }
    var classification: String { species.classification }
    var designation: String { species.designation }
    var averageHeight: String { species.averageHeight }
    var skinColors: String { species.skinColors }
    var hairColors: String { species.hairColors }
    var eyeColors: String { species.eyeColors }
    var averageLifespan: String { species.averageLifespan }
    var language: String { species.language }

    var hasHomeworld: Bool { species.homeworld != nil }
    var homeworld: Planet? { relatedPlanets.first }
}
