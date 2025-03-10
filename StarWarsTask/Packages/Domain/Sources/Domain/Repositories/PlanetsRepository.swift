//
//  PlanetsRepositoryProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation
import Core

public protocol PlanetsRepositoryProtocol {
    func fetchPlanets(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Planet>
    func fetchPlanet(id: Int) async throws -> Planet
    func fetchPlanetByURL(url: String) async throws -> Planet
}

public final class PlanetsRepository: PlanetsRepositoryProtocol {
    private let genericRepository: BaseRepository<PlanetDTO, Planet>
    
    private let planetsListCacheKey = "planets_list"
    private func planetCacheKey(id: Int) -> String {
        return "planet_\(id)"
    }
    private func planetURLCacheKey(url: String) -> String {
        return "planet_url_\(url.hashValue)"
    }
    
	public init(
		apiService: APIServiceProtocol,
		cacheService: StorageServiceProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
        self.genericRepository = BaseRepository<PlanetDTO, Planet>(
            apiService: apiService,
            cacheService: cacheService,
			connectivityService: connectivityService,
            mapDTO: { dto in
				ModelMapper.mapPlanet(dto)
            },
            mapDTOList: { dtoList in
				ModelMapper.mapPlanets(dtoList)
            }
        )
    }
    
	public func fetchPlanets(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Planet> {
        let result = try await genericRepository.fetchList(
            endpoint: .planets,
            page: page,
			cacheKey: planetsListCacheKey,
			forceFetch: forceFetch
        )
		return .init(items: result.items, hasMore: result.hasMore, nextPage: result.nextPage)
    }
    
	public func fetchPlanet(id: Int) async throws -> Planet {
        return try await genericRepository.fetchDetail(
            endpoint: .planetDetail(id: id),
            id: id,
            cacheKey: planetCacheKey(id: id)
        )
    }
    
	public func fetchPlanetByURL(url: String) async throws -> Planet {
        return try await genericRepository.fetchByURL(
            url: url,
            cacheKey: planetURLCacheKey(url: url)
        )
    }
} 
