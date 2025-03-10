//
//  Vehicle.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

public struct Vehicle: Identifiable, Hashable {
	public var id: String { url }
	public let name: String
	public let model: String
	public let manufacturer: String
	public let costInCredits: String
	public let length: String
	public let maxAtmospheringSpeed: String
	public let crew: String
	public let passengers: String
	public let cargoCapacity: String
	public let consumables: String
	public let vehicleClass: String
	public let pilots: [String]
	public let films: [String]
	public let url: String

	public init(
		name: String,
		model: String,
		manufacturer: String,
		costInCredits: String,
		length: String,
		maxAtmospheringSpeed: String,
		crew: String,
		passengers: String,
		cargoCapacity: String,
		consumables: String,
		vehicleClass: String,
		pilots: [String],
		films: [String],
		url: String
	) {
		self.name = name
		self.model = model
		self.manufacturer = manufacturer
		self.costInCredits = costInCredits
		self.length = length
		self.maxAtmospheringSpeed = maxAtmospheringSpeed
		self.crew = crew
		self.passengers = passengers
		self.cargoCapacity = cargoCapacity
		self.consumables = consumables
		self.vehicleClass = vehicleClass
		self.pilots = pilots
		self.films = films
		self.url = url
	}
}
