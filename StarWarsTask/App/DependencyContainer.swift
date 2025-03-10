//
//  DependencyContainer.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation
import Core
import Domain

/// Simple realization of dependency container for using in Views
/// Personally I prefer this realization https://github.com/pointfreeco/swift-dependencies
@MainActor
final class DependencyContainer: ObservableObject {
    // Services
    let apiService: APIServiceProtocol
	let connectivityService: ConnectivityServiceProtocol

    // Repositories
    let peopleRepository: PeopleRepositoryProtocol
    let planetsRepository: PlanetsRepositoryProtocol
    let starshipsRepository: StarshipsRepositoryProtocol
    let vehiclesRepository: VehiclesRepositoryProtocol
    let speciesRepository: SpeciesRepositoryProtocol
    let filmsRepository: FilmsRepositoryProtocol
    
    // Factories
    let viewModelFactory: ViewModelFactoryProtocol
    
    // Navigation
	private(set) lazy var destinationBuilder = ViewDestinationBuilder(viewModelFactory: viewModelFactory)

	init(
		apiService: APIServiceProtocol,
		connectivityService: ConnectivityServiceProtocol,
		peopleRepository: PeopleRepositoryProtocol,
		planetsRepository: PlanetsRepositoryProtocol,
		starshipsRepository: StarshipsRepositoryProtocol,
		vehiclesRepository: VehiclesRepositoryProtocol,
		speciesRepository: SpeciesRepositoryProtocol,
		filmsRepository: FilmsRepositoryProtocol,
		viewModelFactory: ViewModelFactoryProtocol
	) {
		self.apiService = apiService
		self.connectivityService = connectivityService
		self.peopleRepository = peopleRepository
		self.planetsRepository = planetsRepository
		self.starshipsRepository = starshipsRepository
		self.vehiclesRepository = vehiclesRepository
		self.speciesRepository = speciesRepository
		self.filmsRepository = filmsRepository
		self.viewModelFactory = viewModelFactory
	}

    init() {
        self.apiService = APIService()
        self.connectivityService = ConnectivityService()

		let storageService = FileSystemStorageService()

        self.peopleRepository = PeopleRepository(
            apiService: apiService,
            cacheService: storageService,
			connectivityService: connectivityService
        )
        self.planetsRepository = PlanetsRepository(
            apiService: apiService,
            cacheService: storageService,
			connectivityService: connectivityService
        )
        self.starshipsRepository = StarshipsRepository(
            apiService: apiService,
            cacheService: storageService,
			connectivityService: connectivityService
        )
        self.vehiclesRepository = VehiclesRepository(
            apiService: apiService,
            cacheService: storageService,
			connectivityService: connectivityService
        )
        self.speciesRepository = SpeciesRepository(
            apiService: apiService,
            cacheService: storageService,
			connectivityService: connectivityService
        )
        self.filmsRepository = FilmsRepository(
            apiService: apiService,
            cacheService: storageService,
			connectivityService: connectivityService
        )
        
        self.viewModelFactory = ViewModelFactory(
            peopleRepository: peopleRepository,
            planetsRepository: planetsRepository,
            starshipsRepository: starshipsRepository,
            vehiclesRepository: vehiclesRepository,
            speciesRepository: speciesRepository,
            filmsRepository: filmsRepository,
			connectivityService: connectivityService
        )
    }
}
