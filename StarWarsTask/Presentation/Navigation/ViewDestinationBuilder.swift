//
//  ViewDestinationBuilder.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

/// Helper for creating specific views
@MainActor
final class ViewDestinationBuilder {
    private let viewModelFactory: ViewModelFactoryProtocol
    
	// Simple cache for view models
    private var filmsListViewModel: FilmsListViewModel?
    private var peopleListViewModel: PeopleListViewModel?
    private var planetsListViewModel: PlanetsListViewModel?
    private var starshipsListViewModel: StarshipsListViewModel?
    private var vehiclesListViewModel: VehiclesListViewModel?
    private var speciesListViewModel: SpeciesListViewModel?
    
    private var filmDetailViewModels: [String: FilmDetailViewModel] = [:]
    private var personDetailViewModels: [String: PersonDetailViewModel] = [:]
    private var planetDetailViewModels: [String: PlanetDetailViewModel] = [:]
    private var starshipDetailViewModels: [String: StarshipDetailViewModel] = [:]
    private var vehicleDetailViewModels: [String: VehicleDetailViewModel] = [:]
    private var speciesDetailViewModels: [String: SpeciesDetailViewModel] = [:]
    
    init(viewModelFactory: ViewModelFactoryProtocol) {
        self.viewModelFactory = viewModelFactory
    }

    @ViewBuilder
	func buildDestination(for route: AppRoute) -> some View {
		switch route {
				// Dashboard
			case .dashboard:
				DashboardView()

				// Lists
			case .filmsList:
				FilmsListView(viewModel: self.getFilmsListViewModel())
			case .peopleList:
				PeopleListView(viewModel: self.getPeopleListViewModel())
			case .planetsList:
				PlanetsListView(viewModel: self.getPlanetsListViewModel())
			case .starshipsList:
				StarshipsListView(viewModel: self.getStarshipsListViewModel())
			case .vehiclesList:
				VehiclesListView(viewModel: self.getVehiclesListViewModel())
			case .speciesList:
				SpeciesListView(viewModel: self.getSpeciesListViewModel())

				// Details
			case .filmDetail(let film):
				FilmDetailView(viewModel: getFilmDetailViewModel(for: film))
			case .personDetail(let person):
				PersonDetailView(viewModel: getPersonDetailViewModel(for: person))
			case .planetDetail(let planet):
				PlanetDetailView(viewModel: getPlanetDetailViewModel(for: planet))
			case .starshipDetail(let starship):
				StarshipDetailView(viewModel: getStarshipDetailViewModel(for: starship))
			case .vehicleDetail(let vehicle):
				VehicleDetailView(viewModel: getVehicleDetailViewModel(for: vehicle))
			case .speciesDetail(let species):
				SpeciesDetailView(viewModel: getSpeciesDetailViewModel(for: species))
		}
	}
    
    // MARK: - Private Helper Methods
    
    // Lists ViewModels
    private func getFilmsListViewModel() -> FilmsListViewModel {
        if let viewModel = filmsListViewModel {
            return viewModel
        }
        let viewModel = viewModelFactory.makeFilmsListViewModel()
        filmsListViewModel = viewModel
        return viewModel
    }
    
    private func getPeopleListViewModel() -> PeopleListViewModel {
        if let viewModel = peopleListViewModel {
            return viewModel
        }
        let viewModel = viewModelFactory.makePeopleListViewModel()
        peopleListViewModel = viewModel
        return viewModel
    }
    
    private func getPlanetsListViewModel() -> PlanetsListViewModel {
        if let viewModel = planetsListViewModel {
            return viewModel
        }
        let viewModel = viewModelFactory.makePlanetsListViewModel()
        planetsListViewModel = viewModel
        return viewModel
    }
    
    private func getStarshipsListViewModel() -> StarshipsListViewModel {
        if let viewModel = starshipsListViewModel {
            return viewModel
        }
        let viewModel = viewModelFactory.makeStarshipsListViewModel()
        starshipsListViewModel = viewModel
        return viewModel
    }
    
    private func getVehiclesListViewModel() -> VehiclesListViewModel {
        if let viewModel = vehiclesListViewModel {
            return viewModel
        }
        let viewModel = viewModelFactory.makeVehiclesListViewModel()
        vehiclesListViewModel = viewModel
        return viewModel
    }
    
    private func getSpeciesListViewModel() -> SpeciesListViewModel {
        if let viewModel = speciesListViewModel {
            return viewModel
        }
        let viewModel = viewModelFactory.makeSpeciesListViewModel()
        speciesListViewModel = viewModel
        return viewModel
    }
    
    // Detail ViewModels
    private func getFilmDetailViewModel(for film: Film) -> FilmDetailViewModel {
        if let viewModel = filmDetailViewModels[film.id] {
            return viewModel
        }
        let viewModel = viewModelFactory.makeFilmDetailViewModel(film: film)
        filmDetailViewModels[film.id] = viewModel
        return viewModel
    }
    
    private func getPersonDetailViewModel(for person: Person) -> PersonDetailViewModel {
        if let viewModel = personDetailViewModels[person.id] {
            return viewModel
        }
        let viewModel = viewModelFactory.makePersonDetailViewModel(person: person)
        personDetailViewModels[person.id] = viewModel
        return viewModel
    }
    
    private func getPlanetDetailViewModel(for planet: Planet) -> PlanetDetailViewModel {
        if let viewModel = planetDetailViewModels[planet.id] {
            return viewModel
        }
        let viewModel = viewModelFactory.makePlanetDetailViewModel(planet: planet)
        planetDetailViewModels[planet.id] = viewModel
        return viewModel
    }
    
    private func getStarshipDetailViewModel(for starship: Starship) -> StarshipDetailViewModel {
        if let viewModel = starshipDetailViewModels[starship.id] {
            return viewModel
        }
        let viewModel = viewModelFactory.makeStarshipDetailViewModel(starship: starship)
        starshipDetailViewModels[starship.id] = viewModel
        return viewModel
    }
    
    private func getVehicleDetailViewModel(for vehicle: Vehicle) -> VehicleDetailViewModel {
        if let viewModel = vehicleDetailViewModels[vehicle.id] {
            return viewModel
        }
        let viewModel = viewModelFactory.makeVehicleDetailViewModel(vehicle: vehicle)
        vehicleDetailViewModels[vehicle.id] = viewModel
        return viewModel
    }
    
    private func getSpeciesDetailViewModel(for species: Species) -> SpeciesDetailViewModel {
        if let viewModel = speciesDetailViewModels[species.id] {
            return viewModel
        }
        let viewModel = viewModelFactory.makeSpeciesDetailViewModel(species: species)
        speciesDetailViewModels[species.id] = viewModel
        return viewModel
    }
} 
