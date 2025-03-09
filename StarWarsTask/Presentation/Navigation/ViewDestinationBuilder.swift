//
//  ViewDestinationBuilder.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

/// Helper for creating specific views
@MainActor
struct ViewDestinationBuilder {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }

    @ViewBuilder
	func buildDestination(for viewSpec: AppRoute) -> some View {
		switch viewSpec {
				// Dashboard
			case .dashboard:
				DashboardView()

				// Lists
			case .filmsList:
				FilmsListView(viewModel: container.viewModelFactory.makeFilmsListViewModel())
			case .peopleList:
				PeopleListView(viewModel: container.viewModelFactory.makePeopleListViewModel())
			case .planetsList:
				PlanetsListView(viewModel: container.viewModelFactory.makePlanetsListViewModel())
			case .starshipsList:
				StarshipsListView(viewModel: container.viewModelFactory.makeStarshipsListViewModel())
			case .vehiclesList:
				VehiclesListView(viewModel: container.viewModelFactory.makeVehiclesListViewModel())
			case .speciesList:
				SpeciesListView(viewModel: container.viewModelFactory.makeSpeciesListViewModel())

				// Details
			case .filmDetail(let film):
				FilmDetailView(viewModel: container.viewModelFactory.makeFilmDetailViewModel(film: film))
			case .personDetail(let person):
				PersonDetailView(viewModel: container.viewModelFactory.makePersonDetailViewModel(person: person))
			case .planetDetail(let planet):
				PlanetDetailView(viewModel: container.viewModelFactory.makePlanetDetailViewModel(planet: planet))
			case .starshipDetail(let starship):
				StarshipDetailView(viewModel: container.viewModelFactory.makeStarshipDetailViewModel(starship: starship))
			case .vehicleDetail(let vehicle):
				VehicleDetailView(viewModel: container.viewModelFactory.makeVehicleDetailViewModel(vehicle: vehicle))
			case .speciesDetail(let species):
				SpeciesDetailView(viewModel: container.viewModelFactory.makeSpeciesDetailViewModel(species: species))
		}
	}
} 
