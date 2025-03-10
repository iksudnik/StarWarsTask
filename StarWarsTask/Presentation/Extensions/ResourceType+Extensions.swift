//
//  ResourceType+Extensions.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core

extension ResourceType {
	var title: String {
		switch self {
			case .person: return Localized.Details.characters
			case .planet: return Localized.Details.planets
			case .starship: return Localized.Details.starships
			case .vehicle: return Localized.Details.vehicles
			case .species: return Localized.Details.species
			case .film: return Localized.Details.films
		}
	}

	var emptyText: String {
		switch self {
			case .person: return Localized.Details.noCharacters
			case .planet: return Localized.Details.noPlanets
			case .starship: return Localized.Details.noStarships
			case .vehicle: return Localized.Details.noVehicles
			case .species: return Localized.Details.noSpecies
			case .film: return Localized.Details.noFilms
		}
	}
}
