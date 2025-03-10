//
//  Person.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

public struct Person: Identifiable, Hashable {
	public var id: String { url }
	public let name: String
	public let height: String
	public let mass: String
	public let hairColor: String
	public let skinColor: String
	public let eyeColor: String
	public let birthYear: String
	public let gender: String
	public let homeworld: String
	public let films: [String]
	public let species: [String]
	public let vehicles: [String]
	public let starships: [String]
	public let url: String

	public init(
		name: String,
		height: String,
		mass: String,
		hairColor: String,
		skinColor: String,
		eyeColor: String,
		birthYear: String,
		gender: String,
		homeworld: String,
		films: [String],
		species: [String],
		vehicles: [String],
		starships: [String],
		url: String
	) {
		self.name = name
		self.height = height
		self.mass = mass
		self.hairColor = hairColor
		self.skinColor = skinColor
		self.eyeColor = eyeColor
		self.birthYear = birthYear
		self.gender = gender
		self.homeworld = homeworld
		self.films = films
		self.species = species
		self.vehicles = vehicles
		self.starships = starships
		self.url = url
	}
}
