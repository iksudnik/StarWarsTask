//
//  Film.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

public struct Film: Identifiable, Hashable {
	public var id: String { url }
	public let title: String
	public let episodeId: Int
	public let openingCrawl: String
	public let director: String
	public let producer: String
	public let releaseDate: String
	public let characters: [String]
	public let planets: [String]
	public let starships: [String]
	public let vehicles: [String]
	public let species: [String]
	public let url: String

	public init(
		title: String,
		episodeId: Int,
		openingCrawl: String,
		director: String,
		producer: String,
		releaseDate: String,
		characters: [String],
		planets: [String],
		starships: [String],
		vehicles: [String],
		species: [String],
		url: String
	) {
		self.title = title
		self.episodeId = episodeId
		self.openingCrawl = openingCrawl
		self.director = director
		self.producer = producer
		self.releaseDate = releaseDate
		self.characters = characters
		self.planets = planets
		self.starships = starships
		self.vehicles = vehicles
		self.species = species
		self.url = url
	}
}
