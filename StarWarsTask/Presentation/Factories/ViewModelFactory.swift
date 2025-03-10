//
//  ViewModelFactoryProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//


import Foundation
import Core

@MainActor
protocol ViewModelFactoryProtocol {
    // List ViewModels
    func makePeopleListViewModel() -> PeopleListViewModel
    func makePlanetsListViewModel() -> PlanetsListViewModel
    func makeStarshipsListViewModel() -> StarshipsListViewModel
    func makeVehiclesListViewModel() -> VehiclesListViewModel
    func makeSpeciesListViewModel() -> SpeciesListViewModel
    func makeFilmsListViewModel() -> FilmsListViewModel

    // Detail ViewModels
    func makePersonDetailViewModel(person: Person) -> PersonDetailViewModel
    func makePlanetDetailViewModel(planet: Planet) -> PlanetDetailViewModel
    func makeStarshipDetailViewModel(starship: Starship) -> StarshipDetailViewModel
    func makeVehicleDetailViewModel(vehicle: Vehicle) -> VehicleDetailViewModel
    func makeSpeciesDetailViewModel(species: Species) -> SpeciesDetailViewModel
    func makeFilmDetailViewModel(film: Film) -> FilmDetailViewModel
}

final class ViewModelFactory: ViewModelFactoryProtocol {
    private let peopleRepository: PeopleRepositoryProtocol
    private let planetsRepository: PlanetsRepositoryProtocol
    private let starshipsRepository: StarshipsRepositoryProtocol
    private let vehiclesRepository: VehiclesRepositoryProtocol
    private let speciesRepository: SpeciesRepositoryProtocol
    private let filmsRepository: FilmsRepositoryProtocol
    private let connectivityService: ConnectivityServiceProtocol

    init(
        peopleRepository: PeopleRepositoryProtocol,
        planetsRepository: PlanetsRepositoryProtocol,
        starshipsRepository: StarshipsRepositoryProtocol,
        vehiclesRepository: VehiclesRepositoryProtocol,
        speciesRepository: SpeciesRepositoryProtocol,
        filmsRepository: FilmsRepositoryProtocol,
		connectivityService: ConnectivityServiceProtocol
    ) {
        self.peopleRepository = peopleRepository
        self.planetsRepository = planetsRepository
        self.starshipsRepository = starshipsRepository
        self.vehiclesRepository = vehiclesRepository
        self.speciesRepository = speciesRepository
        self.filmsRepository = filmsRepository
        self.connectivityService = connectivityService
    }
    
    // MARK: - List ViewModels
    func makePeopleListViewModel() -> PeopleListViewModel {
        return PeopleListViewModel(repository: peopleRepository, connectivityService: connectivityService)
    }

    func makePlanetsListViewModel() -> PlanetsListViewModel {
        return PlanetsListViewModel(repository: planetsRepository, connectivityService: connectivityService)
    }

    func makeStarshipsListViewModel() -> StarshipsListViewModel {
        return StarshipsListViewModel(repository: starshipsRepository, connectivityService: connectivityService)
    }

	func makeVehiclesListViewModel() -> VehiclesListViewModel {
        return VehiclesListViewModel(repository: vehiclesRepository, connectivityService: connectivityService)
    }

    func makeSpeciesListViewModel() -> SpeciesListViewModel {
        return SpeciesListViewModel(repository: speciesRepository, connectivityService: connectivityService)
    }

    func makeFilmsListViewModel() -> FilmsListViewModel {
        return FilmsListViewModel(repository: filmsRepository, connectivityService: connectivityService)
    }
    
    // MARK: - Detail ViewModels
    
    func makePersonDetailViewModel(person: Person) -> PersonDetailViewModel {
        return PersonDetailViewModel(
            person: person,
            peopleRepository: peopleRepository,
            planetsRepository: planetsRepository,
            starshipsRepository: starshipsRepository,
			vehiclesRepository: vehiclesRepository,
			speciesRepository: speciesRepository,
			filmsRepository: filmsRepository
        )
    }
    
    func makePlanetDetailViewModel(planet: Planet) -> PlanetDetailViewModel {
        return PlanetDetailViewModel(
            planet: planet,
			peopleRepository: peopleRepository,
			filmsRepository: filmsRepository
        )
    }
    
    func makeStarshipDetailViewModel(starship: Starship) -> StarshipDetailViewModel {
        return StarshipDetailViewModel(
            starship: starship,
			peopleRepository: peopleRepository,
			filmsRepository: filmsRepository
        )
    }
    
    func makeVehicleDetailViewModel(vehicle: Vehicle) -> VehicleDetailViewModel {
        return VehicleDetailViewModel(
            vehicle: vehicle,
            peopleRepository: peopleRepository,
            filmsRepository: filmsRepository
        )
    }
    
    func makeSpeciesDetailViewModel(species: Species) -> SpeciesDetailViewModel {
        return SpeciesDetailViewModel(
            species: species,
            peopleRepository: peopleRepository,
            planetsRepository: planetsRepository,
            filmsRepository: filmsRepository
        )
    }
    
	@MainActor
	func makeFilmDetailViewModel(film: Film) -> FilmDetailViewModel {
        return FilmDetailViewModel(
            film: film,
            peopleRepository: peopleRepository,
            planetsRepository: planetsRepository,
            starshipsRepository: starshipsRepository,
            vehiclesRepository: vehiclesRepository,
            speciesRepository: speciesRepository
        )
    }
} 
