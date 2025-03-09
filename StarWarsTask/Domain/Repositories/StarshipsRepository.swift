//
//  StarshipsRepositoryProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

protocol StarshipsRepositoryProtocol {
    func fetchStarships(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Starship>
    func fetchStarship(id: Int) async throws -> Starship
    func fetchStarshipByURL(url: String) async throws -> Starship
}

final class StarshipsRepository: StarshipsRepositoryProtocol {
    private let genericRepository: BaseRepository<StarshipDTO, Starship>
    
    private let starshipsListCacheKey = "starships_list"
    private func starshipCacheKey(id: Int) -> String {
        return "starship_\(id)"
    }
    private func starshipURLCacheKey(url: String) -> String {
        return "starship_url_\(url.hashValue)"
    }
    
	init(
		apiService: APIServiceProtocol,
		cacheService: StorageServiceProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
        self.genericRepository = BaseRepository<StarshipDTO, Starship>(
            apiService: apiService,
            cacheService: cacheService,
			connectivityService: connectivityService,
            mapDTO: { dto in
				ModelMapper.mapStarship(dto)
            },
            mapDTOList: { dtoList in
                ModelMapper.mapStarships(dtoList)
            }
        )
    }
    
    func fetchStarships(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Starship> {
        let result = try await genericRepository.fetchList(
            endpoint: .starships,
            page: page,
			cacheKey: starshipsListCacheKey,
			forceFetch: forceFetch
        )
		return .init(items: result.items, hasMore: result.hasMore, nextPage: result.nextPage)
    }
    
    func fetchStarship(id: Int) async throws -> Starship {
        return try await genericRepository.fetchDetail(
            endpoint: .starshipDetail(id: id),
            id: id,
            cacheKey: starshipCacheKey(id: id)
        )
    }
    
    func fetchStarshipByURL(url: String) async throws -> Starship {
        return try await genericRepository.fetchByURL(
            url: url,
            cacheKey: starshipURLCacheKey(url: url)
        )
    }
} 
