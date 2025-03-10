//
//  Species.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

public struct Species: Identifiable, Hashable {
	public var id: String { url }
	public let name: String
	public let classification: String
	public let designation: String
	public let averageHeight: String
	public let skinColors: String
	public let hairColors: String
	public let eyeColors: String
	public let averageLifespan: String
	public let homeworld: String?
	public let language: String
	public let people: [String]
	public let films: [String]
	public let url: String

	public init(
		name: String,
		classification: String,
		designation: String,
		averageHeight: String,
		skinColors: String,
		hairColors: String,
		eyeColors: String,
		averageLifespan: String,
		homeworld: String? = nil,
		language: String,
		people: [String],
		films: [String],
		url: String
	) {
		self.name = name
		self.classification = classification
		self.designation = designation
		self.averageHeight = averageHeight
		self.skinColors = skinColors
		self.hairColors = hairColors
		self.eyeColors = eyeColors
		self.averageLifespan = averageLifespan
		self.homeworld = homeworld
		self.language = language
		self.people = people
		self.films = films
		self.url = url
	}
}
