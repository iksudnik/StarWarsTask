//
//  FilmsRepositoryProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

protocol FilmsRepositoryProtocol {
	func fetchFilms(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Film>
    func fetchFilm(id: Int) async throws -> Film
    func fetchFilmByURL(url: String) async throws -> Film
}

final class FilmsRepository: FilmsRepositoryProtocol {
    private let genericRepository: BaseRepository<Film>
    
    private let filmsListCacheKey = "films_list"
    private func filmCacheKey(id: Int) -> String {
        return "film_\(id)"
    }
    private func filmURLCacheKey(url: String) -> String {
        return "film_url_\(url.hashValue)"
    }
    
	init(
		apiService: APIServiceProtocol,
		cacheService: StorageServiceProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
        self.genericRepository = BaseRepository<Film>(
            apiService: apiService,
            cacheService: cacheService,
			connectivityService: connectivityService
        )
    }
    
    func fetchFilms(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Film> {
        let result = try await genericRepository.fetchList(
            endpoint: .films,
            page: page,
			cacheKey: filmsListCacheKey, forceFetch: forceFetch
        )
		return .init(items: result.items, hasMore: result.hasMore, nextPage: result.nextPage)
    }
    
    func fetchFilm(id: Int) async throws -> Film {
        return try await genericRepository.fetchDetail(
            endpoint: .filmDetail(id: id),
            id: id,
            cacheKey: filmCacheKey(id: id)
        )
    }
    
    func fetchFilmByURL(url: String) async throws -> Film {
        return try await genericRepository.fetchByURL(
            url: url,
            cacheKey: filmURLCacheKey(url: url)
        )
    }
} 
