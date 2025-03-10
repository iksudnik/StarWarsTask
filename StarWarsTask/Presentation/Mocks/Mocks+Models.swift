//
//  PreviewMocks.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

enum PreviewMocks {
    
    // MARK: - Film Mocks
    enum Films {
        static let newHope = Film(
            title: "A New Hope",
            episodeId: 4,
            openingCrawl: "It is a period of civil war. Rebel spaceships, striking from a hidden base, have won their first victory against the evil Galactic Empire.",
            director: "George Lucas",
            producer: "Gary Kurtz, Rick McCallum",
            releaseDate: "1977-05-25",
            characters: ["https://swapi.dev/api/people/1/", "https://swapi.dev/api/people/2/"],
            planets: ["https://swapi.dev/api/planets/1/"],
            starships: ["https://swapi.dev/api/starships/2/"],
            vehicles: ["https://swapi.dev/api/vehicles/4/"],
            species: ["https://swapi.dev/api/species/1/"],
            url: "https://swapi.dev/api/films/1/"
        )
        
        static let empireStrikesBack = Film(
            title: "The Empire Strikes Back",
            episodeId: 5,
            openingCrawl: "It is a dark time for the Rebellion. Although the Death Star has been destroyed, Imperial troops have driven the Rebel forces from their hidden base and pursued them across the galaxy.",
            director: "Irvin Kershner",
            producer: "Gary Kurtz, Rick McCallum",
            releaseDate: "1980-05-17",
            characters: ["https://swapi.dev/api/people/1/", "https://swapi.dev/api/people/3/"],
            planets: ["https://swapi.dev/api/planets/4/", "https://swapi.dev/api/planets/5/"],
            starships: ["https://swapi.dev/api/starships/3/"],
            vehicles: ["https://swapi.dev/api/vehicles/8/"],
            species: ["https://swapi.dev/api/species/2/"],
            url: "https://swapi.dev/api/films/2/"
        )
        
        static let returnOfTheJedi = Film(
            title: "Return of the Jedi",
            episodeId: 6,
            openingCrawl: "Luke Skywalker has returned to his home planet of Tatooine in an attempt to rescue his friend Han Solo from the clutches of the vile gangster Jabba the Hutt.",
            director: "Richard Marquand",
            producer: "Howard G. Kazanjian, George Lucas, Rick McCallum",
            releaseDate: "1983-05-25",
            characters: ["https://swapi.dev/api/people/1/", "https://swapi.dev/api/people/5/"],
            planets: ["https://swapi.dev/api/planets/1/", "https://swapi.dev/api/planets/8/"],
            starships: ["https://swapi.dev/api/starships/2/", "https://swapi.dev/api/starships/10/"],
            vehicles: ["https://swapi.dev/api/vehicles/8/", "https://swapi.dev/api/vehicles/16/"],
            species: ["https://swapi.dev/api/species/1/", "https://swapi.dev/api/species/5/"],
            url: "https://swapi.dev/api/films/3/"
        )
        
        static let all = [newHope, empireStrikesBack, returnOfTheJedi]
    }
    
    // MARK: - Person Mocks
    enum People {
        static let luke = Person(
            name: "Luke Skywalker",
            height: "172",
            mass: "77",
            hairColor: "blond",
            skinColor: "fair",
            eyeColor: "blue",
            birthYear: "19BBY",
            gender: "male",
            homeworld: "https://swapi.dev/api/planets/1/",
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/"],
            species: [],
            vehicles: ["https://swapi.dev/api/vehicles/14/"],
            starships: ["https://swapi.dev/api/starships/12/"],
            url: "https://swapi.dev/api/people/1/"
        )
        
        static let leia = Person(
            name: "Leia Organa",
            height: "150",
            mass: "49",
            hairColor: "brown",
            skinColor: "light",
            eyeColor: "brown",
            birthYear: "19BBY",
            gender: "female",
            homeworld: "https://swapi.dev/api/planets/2/",
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/"],
            species: [],
            vehicles: ["https://swapi.dev/api/vehicles/30/"],
            starships: [],
            url: "https://swapi.dev/api/people/5/"
        )
        
        static let vader = Person(
            name: "Darth Vader",
            height: "202",
            mass: "136",
            hairColor: "none",
            skinColor: "white",
            eyeColor: "yellow",
            birthYear: "41.9BBY",
            gender: "male",
            homeworld: "https://swapi.dev/api/planets/1/",
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/"],
            species: [],
            vehicles: [],
            starships: ["https://swapi.dev/api/starships/13/"],
            url: "https://swapi.dev/api/people/4/"
        )
        
        static let all = [luke, leia, vader]
    }
    
    // MARK: - Planet Mocks
    enum Planets {
        static let tatooine = Planet(
            name: "Tatooine",
            rotationPeriod: "23",
            orbitalPeriod: "304",
            diameter: "10465",
            climate: "arid",
            gravity: "1 standard",
            terrain: "desert",
            surfaceWater: "1",
            population: "200000",
            residents: ["https://swapi.dev/api/people/1/", "https://swapi.dev/api/people/2/"],
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/planets/1/"
        )
        
        static let alderaan = Planet(
            name: "Alderaan",
            rotationPeriod: "24",
            orbitalPeriod: "364",
            diameter: "12500",
            climate: "temperate",
            gravity: "1 standard",
            terrain: "grasslands, mountains",
            surfaceWater: "40",
            population: "2000000000",
            residents: ["https://swapi.dev/api/people/5/", "https://swapi.dev/api/people/68/"],
            films: ["https://swapi.dev/api/films/1/"],
            url: "https://swapi.dev/api/planets/2/"
        )
        
        static let endor = Planet(
            name: "Endor",
            rotationPeriod: "18",
            orbitalPeriod: "402",
            diameter: "4900",
            climate: "temperate",
            gravity: "0.85 standard",
            terrain: "forests, mountains, lakes",
            surfaceWater: "8",
            population: "30000000",
            residents: ["https://swapi.dev/api/people/30/"],
            films: ["https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/planets/7/"
        )
        
        static let all = [tatooine, alderaan, endor]
    }
    
    // MARK: - Species Mocks
    enum SpeciesCollection {
        static let human = Species(
            name: "Human",
            classification: "mammal",
            designation: "sentient",
            averageHeight: "180",
            skinColors: "caucasian, black, asian, hispanic",
            hairColors: "blonde, brown, black, red",
            eyeColors: "brown, blue, green, hazel, grey, amber",
            averageLifespan: "120",
            homeworld: "https://swapi.dev/api/planets/9/",
            language: "Galactic Basic",
            people: ["https://swapi.dev/api/people/1/", "https://swapi.dev/api/people/4/", "https://swapi.dev/api/people/5/"],
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/species/1/"
        )
        
        static let wookiee = Species(
            name: "Wookiee",
            classification: "mammal",
            designation: "sentient",
            averageHeight: "210",
            skinColors: "gray",
            hairColors: "black, brown",
            eyeColors: "blue, green, yellow, brown, golden, red",
            averageLifespan: "400",
            homeworld: "https://swapi.dev/api/planets/14/",
            language: "Shyriiwook",
            people: ["https://swapi.dev/api/people/13/"],
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/species/3/"
        )
        
        static let ewok = Species(
            name: "Ewok",
            classification: "mammal",
            designation: "sentient",
            averageHeight: "100",
            skinColors: "brown",
            hairColors: "white, brown, black",
            eyeColors: "orange, brown",
            averageLifespan: "unknown",
            homeworld: "https://swapi.dev/api/planets/7/",
            language: "Ewokese",
            people: ["https://swapi.dev/api/people/30/"],
            films: ["https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/species/9/"
        )
        
        static let all = [human, wookiee, ewok]
    }
    
    // MARK: - Starship Mocks
    enum Starships {
        static let xWing = Starship(
            name: "X-wing",
            model: "T-65 X-wing",
            manufacturer: "Incom Corporation",
            costInCredits: "149999",
            length: "12.5",
            maxAtmospheringSpeed: "1050",
            crew: "1",
            passengers: "0",
            cargoCapacity: "110",
            consumables: "1 week",
            hyperdriveRating: "1.0",
            MGLT: "100",
            starshipClass: "Starfighter",
            pilots: ["https://swapi.dev/api/people/1/", "https://swapi.dev/api/people/9/"],
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/starships/12/"
        )
        
        static let millenniumFalcon = Starship(
            name: "Millennium Falcon",
            model: "YT-1300 light freighter",
            manufacturer: "Corellian Engineering Corporation",
            costInCredits: "100000",
            length: "34.37",
            maxAtmospheringSpeed: "1050",
            crew: "4",
            passengers: "6",
            cargoCapacity: "100000",
            consumables: "2 months",
            hyperdriveRating: "0.5",
            MGLT: "75",
            starshipClass: "Light freighter",
            pilots: ["https://swapi.dev/api/people/13/", "https://swapi.dev/api/people/14/", "https://swapi.dev/api/people/25/", "https://swapi.dev/api/people/31/"],
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/starships/10/"
        )
        
        static let starDestroyer = Starship(
            name: "Star Destroyer",
            model: "Imperial I-class Star Destroyer",
            manufacturer: "Kuat Drive Yards",
            costInCredits: "150000000",
            length: "1,600",
            maxAtmospheringSpeed: "975",
            crew: "47,060",
            passengers: "n/a",
            cargoCapacity: "36000000",
            consumables: "2 years",
            hyperdriveRating: "2.0",
            MGLT: "60",
            starshipClass: "Star Destroyer",
            pilots: [],
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/starships/3/"
        )
        
        static let all = [xWing, millenniumFalcon, starDestroyer]
    }
    
    // MARK: - Vehicle Mocks
    enum Vehicles {
        static let sandcrawler = Vehicle(
            name: "Sand Crawler",
            model: "Digger Crawler",
            manufacturer: "Corellia Mining Corporation",
            costInCredits: "150000",
            length: "36.8",
            maxAtmospheringSpeed: "30",
            crew: "46",
            passengers: "30",
            cargoCapacity: "50000",
            consumables: "2 months",
            vehicleClass: "wheeled",
            pilots: [],
            films: ["https://swapi.dev/api/films/1/", "https://swapi.dev/api/films/5/"],
            url: "https://swapi.dev/api/vehicles/4/"
        )
        
        static let atAT = Vehicle(
            name: "AT-AT",
            model: "All Terrain Armored Transport",
            manufacturer: "Kuat Drive Yards, Imperial Department of Military Research",
            costInCredits: "unknown",
            length: "20",
            maxAtmospheringSpeed: "60",
            crew: "5",
            passengers: "40",
            cargoCapacity: "1000",
            consumables: "unknown",
            vehicleClass: "assault walker",
            pilots: [],
            films: ["https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/vehicles/8/"
        )
        
        static let speederbike = Vehicle(
            name: "Speederbike",
            model: "74-Z speeder bike",
            manufacturer: "Aratech Repulsor Company",
            costInCredits: "8000",
            length: "3",
            maxAtmospheringSpeed: "360",
            crew: "1",
            passengers: "1",
            cargoCapacity: "4",
            consumables: "1 day",
            vehicleClass: "speeder",
            pilots: ["https://swapi.dev/api/people/1/", "https://swapi.dev/api/people/5/"],
            films: ["https://swapi.dev/api/films/3/"],
            url: "https://swapi.dev/api/vehicles/30/"
        )
        
        static let all = [sandcrawler, atAT, speederbike]
    }
}

// MARK: - SwiftUI Preview Extensions
extension Film {
    static var preview: Film {
        PreviewMocks.Films.newHope
    }
    
    static var previewList: [Film] {
        PreviewMocks.Films.all
    }
}

extension Person {
    static var preview: Person {
        PreviewMocks.People.luke
    }
    
    static var previewList: [Person] {
        PreviewMocks.People.all
    }
}

extension Planet {
    static var preview: Planet {
        PreviewMocks.Planets.tatooine
    }
    
    static var previewList: [Planet] {
        PreviewMocks.Planets.all
    }
}

extension Species {
    static var preview: Species {
        PreviewMocks.SpeciesCollection.human
    }
    
    static var previewList: [Species] {
        PreviewMocks.SpeciesCollection.all
    }
}

extension Starship {
    static var preview: Starship {
        PreviewMocks.Starships.xWing
    }
    
    static var previewList: [Starship] {
        PreviewMocks.Starships.all
    }
}

extension Vehicle {
    static var preview: Vehicle {
        PreviewMocks.Vehicles.speederbike
    }
    
    static var previewList: [Vehicle] {
        PreviewMocks.Vehicles.all
    }
}
