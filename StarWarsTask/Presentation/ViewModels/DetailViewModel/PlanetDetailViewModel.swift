//
//  PlanetDetailViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

@MainActor
final class PlanetDetailViewModel: BaseDetailViewModel {
    private let planet: Planet

    init(
        planet: Planet,
        peopleRepository: PeopleRepositoryProtocol,
        filmsRepository: FilmsRepositoryProtocol
    ) {
        self.planet = planet
        super.init()
        
        self.peopleRepository = peopleRepository
        self.filmsRepository = filmsRepository
        
        self.peopleURLs = planet.residents
        self.filmsURLs = planet.films
        
        if !planet.residents.isEmpty { self.supportedRelatedTypes.append(.person) }
        if !planet.films.isEmpty { self.supportedRelatedTypes.append(.film) }
    }
}

// MARK: - Properties
extension PlanetDetailViewModel {
    var title: String { planet.name }
    var name: String { planet.name }
    var climate: String { planet.climate }
    var terrain: String { planet.terrain }
    var population: String { planet.population }
    var diameter: String { planet.diameter }
    var gravity: String { planet.gravity }
    var rotationPeriod: String { planet.rotationPeriod }
    var orbitalPeriod: String { planet.orbitalPeriod }
    var surfaceWater: String { planet.surfaceWater }
    
    var planetResidents: [Person] { relatedPeople }
    var planetFilms: [Film] { relatedFilms }
}
