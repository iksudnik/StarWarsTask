//
//  ModelMapper.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

struct ModelMapper {
    
    // MARK: - Film
    static func mapFilm(_ dto: FilmDTO) -> Film {
        return Film(dto: dto)
    }
    
    static func mapFilms(_ dtos: [FilmDTO]) -> [Film] {
        return dtos.map { mapFilm($0) }
    }
    
    // MARK: - Person
    static func mapPerson(_ dto: PersonDTO) -> Person {
        return Person(dto: dto)
    }
    
    static func mapPersons(_ dtos: [PersonDTO]) -> [Person] {
        return dtos.map { mapPerson($0) }
    }
    
    // MARK: - Planet
    static func mapPlanet(_ dto: PlanetDTO) -> Planet {
        return Planet(dto: dto)
    }
    
    static func mapPlanets(_ dtos: [PlanetDTO]) -> [Planet] {
        return dtos.map { mapPlanet($0) }
    }
    
    // MARK: - Starship
    static func mapStarship(_ dto: StarshipDTO) -> Starship {
        return Starship(dto: dto)
    }
    
    static func mapStarships(_ dtos: [StarshipDTO]) -> [Starship] {
        return dtos.map { mapStarship($0) }
    }
    
    // MARK: - Vehicle
    static func mapVehicle(_ dto: VehicleDTO) -> Vehicle {
        return Vehicle(dto: dto)
    }
    
    static func mapVehicles(_ dtos: [VehicleDTO]) -> [Vehicle] {
        return dtos.map { mapVehicle($0) }
    }
    
    // MARK: - Species
    static func mapSpecies(_ dto: SpeciesDTO) -> Species {
        return Species(dto: dto)
    }
    
    static func mapSpeciesList(_ dtos: [SpeciesDTO]) -> [Species] {
        return dtos.map { mapSpecies($0) }
    }
} 

// MARK: - Private initialisers
private extension Film {
	init(dto: FilmDTO) {
		self.title = dto.title
		self.episodeId = dto.episodeId
		self.openingCrawl = dto.openingCrawl
		self.director = dto.director
		self.producer = dto.producer
		self.releaseDate = dto.releaseDate
		self.characters = dto.characters
		self.planets = dto.planets
		self.starships = dto.starships
		self.vehicles = dto.vehicles
		self.species = dto.species
		self.url = dto.url
	}
}

private extension Person {
	init(dto: PersonDTO) {
		self.name = dto.name
		self.height = dto.height
		self.mass = dto.mass
		self.hairColor = dto.hairColor
		self.skinColor = dto.skinColor
		self.eyeColor = dto.eyeColor
		self.birthYear = dto.birthYear
		self.gender = dto.gender
		self.homeworld = dto.homeworld
		self.films = dto.films
		self.species = dto.species
		self.vehicles = dto.vehicles
		self.starships = dto.starships
		self.url = dto.url
	}
}

private extension Planet {
	init(dto: PlanetDTO) {
		self.name = dto.name
		self.rotationPeriod = dto.rotationPeriod
		self.orbitalPeriod = dto.orbitalPeriod
		self.diameter = dto.diameter
		self.climate = dto.climate
		self.gravity = dto.gravity
		self.terrain = dto.terrain
		self.surfaceWater = dto.surfaceWater
		self.population = dto.population
		self.residents = dto.residents
		self.films = dto.films
		self.url = dto.url
	}
}

private extension Species {
	init(dto: SpeciesDTO) {
		self.name = dto.name
		self.classification = dto.classification
		self.designation = dto.designation
		self.averageHeight = dto.averageHeight
		self.skinColors = dto.skinColors
		self.hairColors = dto.hairColors
		self.eyeColors = dto.eyeColors
		self.averageLifespan = dto.averageLifespan
		self.homeworld = dto.homeworld
		self.language = dto.language
		self.people = dto.people
		self.films = dto.films
		self.url = dto.url
	}
}


private extension Starship {
	init(dto: StarshipDTO) {
		self.name = dto.name
		self.model = dto.model
		self.manufacturer = dto.manufacturer
		self.costInCredits = dto.costInCredits
		self.length = dto.length
		self.maxAtmospheringSpeed = dto.maxAtmospheringSpeed
		self.crew = dto.crew
		self.passengers = dto.passengers
		self.cargoCapacity = dto.cargoCapacity
		self.consumables = dto.consumables
		self.hyperdriveRating = dto.hyperdriveRating
		self.MGLT = dto.MGLT
		self.starshipClass = dto.starshipClass
		self.pilots = dto.pilots
		self.films = dto.films
		self.url = dto.url
	}
}


private extension Vehicle {
	init(dto: VehicleDTO) {
		self.name = dto.name
		self.model = dto.model
		self.manufacturer = dto.manufacturer
		self.costInCredits = dto.costInCredits
		self.length = dto.length
		self.maxAtmospheringSpeed = dto.maxAtmospheringSpeed
		self.crew = dto.crew
		self.passengers = dto.passengers
		self.cargoCapacity = dto.cargoCapacity
		self.consumables = dto.consumables
		self.vehicleClass = dto.vehicleClass
		self.pilots = dto.pilots
		self.films = dto.films
		self.url = dto.url
	}
}
