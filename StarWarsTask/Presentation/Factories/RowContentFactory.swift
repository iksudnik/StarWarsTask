//
//  RowContentFactory.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

struct RowContentFactory {
    
    // MARK: - Person Row
    static func makePersonRow(for person: Person) -> some View {
        GenericRow(
            title: person.name,
            leftLabel: Localized.Character.gender,
            leftValue: person.gender,
            rightLabel: Localized.Character.birthYear,
            rightValue: person.birthYear
        )
    }
    
    // MARK: - Planet Row
        static func makePlanetRow(for planet: Planet) -> some View {
        GenericRow(
            title: planet.name,
            leftLabel: Localized.Planet.climate,
            leftValue: planet.climate,
            rightLabel: Localized.Planet.population,
            rightValue: planet.population
        )
    }
    
    // MARK: - Starship Row
	static func makeStarshipRow(for starship: Starship) -> some View {
        GenericRow(
            title: starship.name,
            leftLabel: Localized.Starship.model,
            leftValue: starship.model,
            rightLabel: Localized.Starship.starshipClass,
            rightValue: starship.starshipClass
        )
    }
    
    // MARK: - Vehicle Row
	static func makeVehicleRow(for vehicle: Vehicle) -> some View {
        GenericRow(
            title: vehicle.name,
            leftLabel: Localized.Vehicle.model,
            leftValue: vehicle.model,
            rightLabel: Localized.Vehicle.vehicleClass,
            rightValue: vehicle.vehicleClass
        )
    }
    
    // MARK: - Species Row
	static func makeSpeciesRow(for species: Species) -> some View {
        GenericRow(
            title: species.name,
            leftLabel: Localized.Species.classification,
            leftValue: species.classification,
            rightLabel: Localized.Species.language,
            rightValue: species.language
        )
    }
    
    // MARK: - Film Row
	static func makeFilmRow(for film: Film) -> some View {
        GenericRow(
            title: film.title,
            leftLabel: Localized.Film.episodeId,
            leftValue: String(film.episodeId),
            rightLabel: Localized.Film.director,
            rightValue: film.director
        )
    }
    
    // MARK: - Generic Row by ResourceType
	static func makeRowByResourceType<T>(_ item: T) -> some View {
		Group {
			if let person = item as? Person {
				makePersonRow(for: person)
			} else if let planet = item as? Planet {
				makePlanetRow(for: planet)
			} else if let starship = item as? Starship {
				makeStarshipRow(for: starship)
			} else if let vehicle = item as? Vehicle {
				makeVehicleRow(for: vehicle)
			} else if let species = item as? Species {
				makeSpeciesRow(for: species)
			} else if let film = item as? Film {
				makeFilmRow(for: film)
			} else {
				EmptyView()
			}
		}
	}
} 
