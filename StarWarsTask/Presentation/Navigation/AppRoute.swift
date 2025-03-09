//
//  AppRoute.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Foundation

enum AppRoute: Hashable, Identifiable {
    case dashboard
    
    case filmsList
    case peopleList
    case planetsList
    case starshipsList
    case vehiclesList
    case speciesList
    
	/// For deep linking would better to use id as parameter
	case filmDetail(_ film: Film)
    case personDetail(_ person: Person)
    case planetDetail(_ planet: Planet)
    case starshipDetail(_ starship: Starship)
    case vehicleDetail(_ vehicle: Vehicle)
    case speciesDetail(_ species: Species)

    var id: Self { self }
} 
