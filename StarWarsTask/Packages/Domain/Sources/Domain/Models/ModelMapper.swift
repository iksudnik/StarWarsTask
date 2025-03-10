//
//  ModelMapper.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation
import Core

struct ModelMapper {
    
    // MARK: - Film
    static func mapFilm(_ dto: FilmDTO) -> Film {
        return Film(
            title: dto.title,
            episodeId: dto.episodeId,
            openingCrawl: dto.openingCrawl,
            director: dto.director,
            producer: dto.producer,
            releaseDate: dto.releaseDate,
            characters: dto.characters,
            planets: dto.planets,
            starships: dto.starships,
            vehicles: dto.vehicles,
            species: dto.species,
            url: dto.url
        )
    }
    
    static func mapFilms(_ dtos: [FilmDTO]) -> [Film] {
        return dtos.map { mapFilm($0) }
    }
    
    // MARK: - Person
    static func mapPerson(_ dto: PersonDTO) -> Person {
        return Person(
            name: dto.name,
            height: dto.height,
            mass: dto.mass,
            hairColor: dto.hairColor,
            skinColor: dto.skinColor,
            eyeColor: dto.eyeColor,
            birthYear: dto.birthYear,
            gender: dto.gender,
            homeworld: dto.homeworld,
            films: dto.films,
            species: dto.species,
            vehicles: dto.vehicles,
            starships: dto.starships,
            url: dto.url
        )
    }
    
    static func mapPersons(_ dtos: [PersonDTO]) -> [Person] {
        return dtos.map { mapPerson($0) }
    }
    
    // MARK: - Planet
    static func mapPlanet(_ dto: PlanetDTO) -> Planet {
        return Planet(
            name: dto.name,
            rotationPeriod: dto.rotationPeriod,
            orbitalPeriod: dto.orbitalPeriod,
            diameter: dto.diameter,
            climate: dto.climate,
            gravity: dto.gravity,
            terrain: dto.terrain,
            surfaceWater: dto.surfaceWater,
            population: dto.population,
            residents: dto.residents,
            films: dto.films,
            url: dto.url
        )
    }
    
    static func mapPlanets(_ dtos: [PlanetDTO]) -> [Planet] {
        return dtos.map { mapPlanet($0) }
    }
    
    // MARK: - Starship
    static func mapStarship(_ dto: StarshipDTO) -> Starship {
        return Starship(
            name: dto.name,
            model: dto.model,
            manufacturer: dto.manufacturer,
            costInCredits: dto.costInCredits,
            length: dto.length,
            maxAtmospheringSpeed: dto.maxAtmospheringSpeed,
            crew: dto.crew,
            passengers: dto.passengers,
            cargoCapacity: dto.cargoCapacity,
            consumables: dto.consumables,
            hyperdriveRating: dto.hyperdriveRating,
            MGLT: dto.MGLT,
            starshipClass: dto.starshipClass,
            pilots: dto.pilots,
            films: dto.films,
            url: dto.url
        )
    }
    
    static func mapStarships(_ dtos: [StarshipDTO]) -> [Starship] {
        return dtos.map { mapStarship($0) }
    }
    
    // MARK: - Vehicle
    static func mapVehicle(_ dto: VehicleDTO) -> Vehicle {
        return Vehicle(
            name: dto.name,
            model: dto.model,
            manufacturer: dto.manufacturer,
            costInCredits: dto.costInCredits,
            length: dto.length,
            maxAtmospheringSpeed: dto.maxAtmospheringSpeed,
            crew: dto.crew,
            passengers: dto.passengers,
            cargoCapacity: dto.cargoCapacity,
            consumables: dto.consumables,
            vehicleClass: dto.vehicleClass,
            pilots: dto.pilots,
            films: dto.films,
            url: dto.url
        )
    }
    
    static func mapVehicles(_ dtos: [VehicleDTO]) -> [Vehicle] {
        return dtos.map { mapVehicle($0) }
    }
    
    // MARK: - Species
    static func mapSpecies(_ dto: SpeciesDTO) -> Species {
        return Species(
            name: dto.name,
            classification: dto.classification,
            designation: dto.designation,
            averageHeight: dto.averageHeight,
            skinColors: dto.skinColors,
            hairColors: dto.hairColors,
            eyeColors: dto.eyeColors,
            averageLifespan: dto.averageLifespan,
            homeworld: dto.homeworld,
            language: dto.language,
            people: dto.people,
            films: dto.films,
            url: dto.url
        )
    }
    
    static func mapSpeciesList(_ dtos: [SpeciesDTO]) -> [Species] {
        return dtos.map { mapSpecies($0) }
    }
}
