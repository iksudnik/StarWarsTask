//
//  Localized.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

// Simple replacement for real localized strings' logic
public enum Localized {
    // MARK: - General Titles
    public enum Titles {
        public static let starWarsHeader = "STAR WARS"
        public static let byJakala = "by Jakala"
    }
    
    // MARK: - UI Elements
    public enum UI {
        public static let error = "Error"
        public static let refresh = "Refresh"
        public static let noInternetNoCache = "No internet connection and no cached data"
        public static let noDataAvailable = "No Data Available"
        public static let dataWillAppearHere = "Data will appear here once loaded"
        public static let tryAgain = "Try Again"
		public static let watchOpeningCrawl = "Watch Opening Crawl"
    }

	// MARK: - Common details strings
	public enum Details {
		public static let name = "Name"
		public static let basicInfo = "Basic Info"

		public static let films = "Films"
		public static let characters = "Characters"
		public static let planets = "Planets"
		public static let starships = "Starships"
		public static let vehicles = "Vehicles"
		public static let species = "Species"

		public static let noFilms = "No films"
		public static let noCharacters = "No characters"
		public static let noPlanets = "No planets"
		public static let noStarships = "No starships"
		public static let noVehicles = "No vehicles"
		public static let noSpecies = "No species"

		public static let physicalTraits = "Physical Traits"
		public static let technicalSpecs = "Technical Specs"
		public static let economicInfo = "Economic Info"
	}

    // MARK: - Character related strings
    public enum Character {
		public static let title = "Characters"
        public static let gender = "Gender"
        public static let birthYear = "Birth Year"
        public static let height = "Height"
        public static let weight = "Weight"
        public static let hairColor = "Hair Color"
        public static let skinColor = "Skin Color"
        public static let eyeColor = "Eye Color"
    }
    
    // MARK: - Planet related strings
    public enum Planet {
		public static let title = "Planets"
		public static let orbitalInfo = "Orbital Info"
        public static let climate = "Climate"
        public static let terrain = "Terrain"
        public static let population = "Population"
        public static let diameter = "Diameter"
        public static let gravity = "Gravity"
        public static let rotationPeriod = "Rotation Period"
        public static let orbitalPeriod = "Orbital Period"
        public static let surfaceWater = "Surface Water"
    }
    
    // MARK: - Starship related strings
    public enum Starship {
        public static let title = "Starships"
        public static let model = "Model"
        public static let manufacturer = "Manufacturer"
        public static let starshipClass = "Class"
        public static let cost = "Cost"
        public static let length = "Length"
        public static let crew = "Crew"
        public static let passengers = "Passengers"
        public static let maxSpeed = "Max Speed"
        public static let hyperdrive = "Hyperdrive"
        public static let mglt = "MGLT"
        public static let cargoCapacity = "Cargo Capacity"
        public static let consumables = "Consumables"
    }
    
    // MARK: - Vehicle related strings
    public enum Vehicle {
        public static let title = "Vehicles"
        public static let model = "Model"
        public static let manufacturer = "Manufacturer"
        public static let vehicleClass = "Class"
        public static let cost = "Cost"
        public static let length = "Length"
        public static let crew = "Crew"
        public static let passengers = "Passengers"
        public static let maxSpeed = "Max Speed"
        public static let cargoCapacity = "Cargo Capacity"
        public static let consumables = "Consumables"
    }
    
    // MARK: - Species related strings
    public enum Species {
        public static let title = "Species"
        public static let classification = "Classification"
        public static let designation = "Designation"
        public static let averageHeight = "Average Height"
        public static let skinColors = "Skin Colors"
        public static let hairColors = "Hair Colors"
        public static let eyeColors = "Eye Colors"
        public static let averageLifespan = "Average Lifespan"
        public static let language = "Language"
    }
    
    // MARK: - Film related strings
    public enum Film {
        public static let title = "Films"
        public static let episodeId = "Episode"
        public static let director = "Director"
        public static let producer = "Producer"
        public static let releaseDate = "Release Date"
        public static let openingCrawl = "Opening Crawl"
    }
    
    // MARK: - Units
    public enum Units {
        public static let cm = "cm"
        public static let kg = "kg"
        public static let km = "km"
        public static let days = "days"
        public static let percent = "%"
        public static let credits = "credits"
        public static let kmh = "km/h"
        public static let meters = "m"
        public static let years = "years"
    }
} 
