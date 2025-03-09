//
//  Localized.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

// Simple replacement for real localized strings' logic
enum Localized {
    // MARK: - General Titles
    enum Titles {
        static let starWarsHeader = "STAR WARS"
        static let byJakala = "by Jakala"
    }
    
    // MARK: - UI Elements
    enum UI {
        static let error = "Error"
        static let refresh = "Refresh"
        static let noInternetNoCache = "No internet connection and no cached data"
        static let noDataAvailable = "No Data Available"
        static let dataWillAppearHere = "Data will appear here once loaded"
        static let tryAgain = "Try Again"
    }

	// MARK: - Common details strings
	enum Details {
		static let name = "Name"
		static let basicInfo = "Basic Info"

		static let films = "Films"
		static let characters = "Characters"
		static let planets = "Planets"
		static let starships = "Starships"
		static let vehicles = "Vehicles"
		static let species = "Species"

		static let noFilms = "No films"
		static let noCharacters = "No characters"
		static let noPlanets = "No planets"
		static let noStarships = "No starships"
		static let noVehicles = "No vehicles"
		static let noSpecies = "No species"

		static let physicalTraits = "Physical Traits"
		static let technicalSpecs = "Technical Specs"
		static let economicInfo = "Economic Info"
	}

    // MARK: - Character related strings
    enum Character {
		static let title = "Characters"
        static let gender = "Gender"
        static let birthYear = "Birth Year"
        static let height = "Height"
        static let weight = "Weight"
        static let hairColor = "Hair Color"
        static let skinColor = "Skin Color"
        static let eyeColor = "Eye Color"
    }
    
    // MARK: - Planet related strings
    enum Planet {
		static let title = "Planets"
		static let orbitalInfo = "Orbital Info"
        static let climate = "Climate"
        static let terrain = "Terrain"
        static let population = "Population"
        static let diameter = "Diameter"
        static let gravity = "Gravity"
        static let rotationPeriod = "Rotation Period"
        static let orbitalPeriod = "Orbital Period"
        static let surfaceWater = "Surface Water"
    }
    
    // MARK: - Starship related strings
    enum Starship {
        static let title = "Starships"
        static let model = "Model"
        static let manufacturer = "Manufacturer"
        static let starshipClass = "Class"
        static let cost = "Cost"
        static let length = "Length"
        static let crew = "Crew"
        static let passengers = "Passengers"
        static let maxSpeed = "Max Speed"
        static let hyperdrive = "Hyperdrive"
        static let mglt = "MGLT"
        static let cargoCapacity = "Cargo Capacity"
        static let consumables = "Consumables"
    }
    
    // MARK: - Vehicle related strings
    enum Vehicle {
        static let title = "Vehicles"
        static let model = "Model"
        static let manufacturer = "Manufacturer"
        static let vehicleClass = "Class"
        static let cost = "Cost"
        static let length = "Length"
        static let crew = "Crew"
        static let passengers = "Passengers"
        static let maxSpeed = "Max Speed"
        static let cargoCapacity = "Cargo Capacity"
        static let consumables = "Consumables"
    }
    
    // MARK: - Species related strings
    enum Species {
        static let title = "Species"
        static let classification = "Classification"
        static let designation = "Designation"
        static let averageHeight = "Average Height"
        static let skinColors = "Skin Colors"
        static let hairColors = "Hair Colors"
        static let eyeColors = "Eye Colors"
        static let averageLifespan = "Average Lifespan"
        static let language = "Language"
    }
    
    // MARK: - Film related strings
    enum Film {
        static let title = "Films"
        static let episodeId = "Episode"
        static let director = "Director"
        static let producer = "Producer"
        static let releaseDate = "Release Date"
        static let openingCrawl = "Opening Crawl"
    }
    
    // MARK: - Units
    enum Units {
        static let cm = "cm"
        static let kg = "kg"
        static let km = "km"
        static let days = "days"
        static let percent = "%"
        static let credits = "credits"
        static let kmh = "km/h"
        static let meters = "m"
        static let years = "years"
    }
} 
