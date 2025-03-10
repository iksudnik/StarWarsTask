//
//  SpeciesRepositoryProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation
import Core

protocol SpeciesRepositoryProtocol {
    func fetchSpecies(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Species>
    func fetchSpeciesDetail(id: Int) async throws -> Species
    func fetchSpeciesByURL(url: String) async throws -> Species
}

final class SpeciesRepository: SpeciesRepositoryProtocol {
    private let genericRepository: BaseRepository<SpeciesDTO, Species>
    
    private let speciesListCacheKey = "species_list"
    private func speciesCacheKey(id: Int) -> String {
        return "species_\(id)"
    }
    private func speciesURLCacheKey(url: String) -> String {
        return "species_url_\(url.hashValue)"
    }
    
	init(
		apiService: APIServiceProtocol,
		cacheService: StorageServiceProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
        self.genericRepository = BaseRepository<SpeciesDTO, Species>(
            apiService: apiService,
            cacheService: cacheService,
			connectivityService: connectivityService,
            mapDTO: { dto in
				ModelMapper.mapSpecies(dto)
            },
            mapDTOList: { dtoList in
				ModelMapper.mapSpeciesList(dtoList)
            }
        )
    }
    
    func fetchSpecies(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Species> {
        let result = try await genericRepository.fetchList(
            endpoint: .species,
            page: page,
			cacheKey: speciesListCacheKey,
			forceFetch: forceFetch
        )
		return .init(items: result.items, hasMore: result.hasMore, nextPage: result.nextPage)
    }
    
    func fetchSpeciesDetail(id: Int) async throws -> Species {
        return try await genericRepository.fetchDetail(
            endpoint: .speciesDetail(id: id),
            id: id,
            cacheKey: speciesCacheKey(id: id)
        )
    }
    
    func fetchSpeciesByURL(url: String) async throws -> Species {
        return try await genericRepository.fetchByURL(
            url: url,
            cacheKey: speciesURLCacheKey(url: url)
        )
    }
} 
