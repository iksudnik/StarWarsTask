//
//  Species.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

struct Species: Identifiable, Hashable {
	var id: String { url }
    let name: String
    let classification: String
    let designation: String
    let averageHeight: String
    let skinColors: String
    let hairColors: String
    let eyeColors: String
    let averageLifespan: String
    let homeworld: String?
    let language: String
    let people: [String]
    let films: [String]
    let url: String
} 
