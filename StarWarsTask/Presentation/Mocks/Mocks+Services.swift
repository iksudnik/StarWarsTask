//
//  Mocks+Services.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Foundation
import SwiftUI

// MARK: - Mock Services
final class MockAPIService: APIServiceProtocol {
	func fetch<T>(endpoint: APIEndpoint, page: Int) async throws -> T where T : Decodable {
        switch endpoint {
        case .films, .filmDetail:
            if T.self == [Film].self {
                return Film.previewList as! T
            } else if T.self == Film.self {
                return Film.preview as! T
            }
        case .people, .personDetail:
            if T.self == [Person].self {
                return Person.previewList as! T
            } else if T.self == Person.self {
                return Person.preview as! T
            }
        case .planets, .planetDetail:
            if T.self == [Planet].self {
                return Planet.previewList as! T
            } else if T.self == Planet.self {
                return Planet.preview as! T
            }
        case .starships, .starshipDetail:
            if T.self == [Starship].self {
                return Starship.previewList as! T
            } else if T.self == Starship.self {
                return Starship.preview as! T
            }
        case .vehicles, .vehicleDetail:
            if T.self == [Vehicle].self {
                return Vehicle.previewList as! T
            } else if T.self == Vehicle.self {
                return Vehicle.preview as! T
            }
        case .species, .speciesDetail:
            if T.self == [Species].self {
                return Species.previewList as! T
            } else if T.self == Species.self {
                return Species.preview as! T
            }
        }
        
        throw APIError.decodingError(NSError(domain: "Mocks", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unsupported type in mock"]))
    }
    
    func fetchByURL<T: Decodable>(url: String) async throws -> T {
        if url.contains("/people/") || url.contains("/characters/") {
            return Person.preview as! T
        } else if url.contains("/planets/") {
            return Planet.preview as! T
        } else if url.contains("/starships/") {
            return Starship.preview as! T
        } else if url.contains("/vehicles/") {
            return Vehicle.preview as! T
        } else if url.contains("/species/") {
            return Species.preview as! T
        } else if url.contains("/films/") {
            return Film.preview as! T
        }
        
        throw APIError.decodingError(NSError(domain: "Mocks", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unsupported URL in  mock"]))
    }
}

final class MockConnectivityService: ConnectivityServiceProtocol {
	private let connectivityContinuation: AsyncStream<Bool>.Continuation
	private(set) var connectivityUpdates: AsyncStream<Bool>

	let isConnected: Bool

	init(isConnected: Bool = true) {
		self.isConnected = isConnected

		var continuation: AsyncStream<Bool>.Continuation!
		connectivityUpdates = AsyncStream { outputContinuation in
			continuation = outputContinuation
			outputContinuation.yield(isConnected)
		}
		self.connectivityContinuation = continuation
	}
}

// MARK: - Mock Repositories
class MockPeopleRepository: PeopleRepositoryProtocol {
    func fetchPeople(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Person> {
        return RepositoryFetchResult(items: Person.previewList, hasMore: false, nextPage: nil)
    }
    
    func fetchPerson(id: Int) async throws -> Person {
        return Person.preview
    }
    
    func fetchPersonByURL(url: String) async throws -> Person {
        return Person.preview
    }
}

class MockPlanetsRepository: PlanetsRepositoryProtocol {
    func fetchPlanets(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Planet> {
        return RepositoryFetchResult(items: Planet.previewList, hasMore: false, nextPage: nil)
    }
    
    func fetchPlanet(id: Int) async throws -> Planet {
        return Planet.preview
    }
    
    func fetchPlanetByURL(url: String) async throws -> Planet {
        return Planet.preview
    }
}

class MockStarshipsRepository: StarshipsRepositoryProtocol {
    func fetchStarships(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Starship> {
        return RepositoryFetchResult(items: Starship.previewList, hasMore: false, nextPage: nil)
    }
    
    func fetchStarship(id: Int) async throws -> Starship {
        return Starship.preview
    }
    
    func fetchStarshipByURL(url: String) async throws -> Starship {
        return Starship.preview
    }
}

class MockVehiclesRepository: VehiclesRepositoryProtocol {
    func fetchVehicles(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Vehicle> {
        return RepositoryFetchResult(items: Vehicle.previewList, hasMore: false, nextPage: nil)
    }
    
    func fetchVehicle(id: Int) async throws -> Vehicle {
        return Vehicle.preview
    }
    
    func fetchVehicleByURL(url: String) async throws -> Vehicle {
        return Vehicle.preview
    }
}

class MockSpeciesRepository: SpeciesRepositoryProtocol {
    func fetchSpecies(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Species> {
        return RepositoryFetchResult(items: Species.previewList, hasMore: false, nextPage: nil)
    }
    
    func fetchSpeciesDetail(id: Int) async throws -> Species {
        return Species.preview
    }
    
    func fetchSpeciesByURL(url: String) async throws -> Species {
        return Species.preview
    }
}

class MockFilmsRepository: FilmsRepositoryProtocol {
    func fetchFilms(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Film> {
        return RepositoryFetchResult(items: Film.previewList, hasMore: false, nextPage: nil)
    }
    
    func fetchFilm(id: Int) async throws -> Film {
        return Film.preview
    }
    
    func fetchFilmByURL(url: String) async throws -> Film {
        return Film.preview
    }
}

class MockFilmsRepositoryNoInternetNoCache: FilmsRepositoryProtocol {
	func fetchFilms(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Film> {
		throw RepositoryError.noInternetNoCache
	}

	func fetchFilm(id: Int) async throws -> Film {
		throw RepositoryError.noInternetNoCache
	}

	func fetchFilmByURL(url: String) async throws -> Film {
		throw RepositoryError.noInternetNoCache
	}
}

// MARK: - Mock DependencyContainer
extension DependencyContainer {
    static let preview: DependencyContainer = {
        let mockAPIService = MockAPIService()
        let mockConnectivityService = MockConnectivityService()
        
        let mockPeopleRepository = MockPeopleRepository()
        let mockPlanetsRepository = MockPlanetsRepository()
        let mockStarshipsRepository = MockStarshipsRepository()
        let mockVehiclesRepository = MockVehiclesRepository()
        let mockSpeciesRepository = MockSpeciesRepository()
        let mockFilmsRepository = MockFilmsRepository()
        
        let mockViewModelFactory = ViewModelFactory(
            peopleRepository: mockPeopleRepository,
            planetsRepository: mockPlanetsRepository,
            starshipsRepository: mockStarshipsRepository,
            vehiclesRepository: mockVehiclesRepository,
            speciesRepository: mockSpeciesRepository,
            filmsRepository: mockFilmsRepository,
            connectivityService: mockConnectivityService
        )
        
        return DependencyContainer(
            apiService: mockAPIService,
            connectivityService: mockConnectivityService,
            peopleRepository: mockPeopleRepository,
            planetsRepository: mockPlanetsRepository,
            starshipsRepository: mockStarshipsRepository,
            vehiclesRepository: mockVehiclesRepository,
            speciesRepository: mockSpeciesRepository,
            filmsRepository: mockFilmsRepository,
            viewModelFactory: mockViewModelFactory
        )
    }()
}
