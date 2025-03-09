//
//  Router.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

/// Class to handle app routing
@MainActor
final class Router: ObservableObject {
	@Published var navigationPath = [AppRoute]()

    // MARK: - Public
    func navigateTo(_ route: AppRoute) {
        navigationPath.append(route)
    }

    func navigateBack() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    func navigateToRoot() {
        navigationPath.removeAll()
    }

    func setPath(_ path: [AppRoute]) {
        navigationPath = path
    }
    
    // MARK: - View navigation methods
    func navigateToList(for resourceType: ResourceType) {
        let route: AppRoute
        
        switch resourceType {
        case .film:
            route = .filmsList
        case .person:
            route = .peopleList
        case .planet:
            route = .planetsList
        case .starship:
            route = .starshipsList
        case .vehicle:
            route = .vehiclesList
        case .species:
            route = .speciesList
        }
		
        navigateTo(route)
    }

    func navigateToDetail<T: Identifiable>(for item: T, resourceType: ResourceType) {
		var route: AppRoute?

		switch resourceType {
			case .film:
				if let film = item as? Film {
					route = .filmDetail(film)
				}
			case .person:
				if let person = item as? Person {
					route = .personDetail(person)
				}
			case .planet:
				if let planet = item as? Planet {
					route = .planetDetail(planet)
				}
			case .starship:
				if let starship = item as? Starship {
					route = .starshipDetail(starship)
				}
			case .vehicle:
				if let vehicle = item as? Vehicle {
					route = .vehicleDetail(vehicle)
				}
			case .species:
				if let species = item as? Species {
					route = .speciesDetail(species)
				}
		}

		if let route {
			navigateTo(route)
		}
    }
} 
