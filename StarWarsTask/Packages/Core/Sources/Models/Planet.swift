//
//  Planet.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

public struct Planet: Identifiable, Hashable {
	public var id: String { url }
	public let name: String
	public let rotationPeriod: String
	public let orbitalPeriod: String
	public let diameter: String
	public let climate: String
	public let gravity: String
	public let terrain: String
	public let surfaceWater: String
	public let population: String
	public let residents: [String]
	public let films: [String]
	public let url: String

	public init(
		name: String,
		rotationPeriod: String,
		orbitalPeriod: String,
		diameter: String,
		climate: String,
		gravity: String,
		terrain: String,
		surfaceWater: String,
		population: String,
		residents: [String],
		films: [String],
		url: String
	) {
		self.name = name
		self.rotationPeriod = rotationPeriod
		self.orbitalPeriod = orbitalPeriod
		self.diameter = diameter
		self.climate = climate
		self.gravity = gravity
		self.terrain = terrain
		self.surfaceWater = surfaceWater
		self.population = population
		self.residents = residents
		self.films = films
		self.url = url
	}

}
