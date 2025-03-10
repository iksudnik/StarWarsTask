//
//  BaseRepositoryProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation
import Core

/// Protocol for a generic repository that can work with any data type
protocol BaseRepositoryProtocol<DTO, T> {
    associatedtype DTO: Codable
    associatedtype T: Identifiable & Hashable
    
    /// Fetches a list of objects with pagination support
	func fetchList(
		endpoint: APIEndpoint,
		page: Int,
		cacheKey: String,
		forceFetch: Bool
	) async throws -> RepositoryFetchResult<T>

    /// Fetches a single object by ID
    func fetchDetail(endpoint: APIEndpoint, id: Int, cacheKey: String) async throws -> T
    
    /// Fetches a single object by URL
    func fetchByURL(url: String, cacheKey: String) async throws -> T
}

/// Structure for storing fetched DTO items with pagination information
private struct DTOFetchPageResult<T: Codable>: Codable {
	let items: [T]
	let hasMore: Bool
	let nextPage: Int?
}

final class BaseRepository<DTO: Codable, T: Identifiable & Hashable>: BaseRepositoryProtocol {
    private let apiService: APIServiceProtocol
    private let cacheService: StorageServiceProtocol
    private let connectivityService: ConnectivityServiceProtocol
    private let mapDTO: (DTO) -> T
    private let mapDTOList: ([DTO]) -> [T]

	init(
		apiService: APIServiceProtocol,
		cacheService: StorageServiceProtocol,
		connectivityService: ConnectivityServiceProtocol,
        mapDTO: @escaping (DTO) -> T,
        mapDTOList: @escaping ([DTO]) -> [T]
	) {
        self.apiService = apiService
        self.cacheService = cacheService
        self.connectivityService = connectivityService
        self.mapDTO = mapDTO
        self.mapDTOList = mapDTOList
    }
    
    // MARK: - Public Methods
	func fetchList(
		endpoint: APIEndpoint,
		page: Int = 1,
		cacheKey: String,
		forceFetch: Bool
	) async throws -> RepositoryFetchResult<T> {

		let currentCacheKey = "\(cacheKey)_page_\(page)"
        
		let dtoResult = try await fetchWithCache(
            forceFetch: forceFetch,
            cacheKey: currentCacheKey,
            fetchFromAPI: {
                let response: APIResponse<DTO> = try await self.apiService.fetch(endpoint: endpoint, page: page)
                let nextPage: Int? = response.next != nil ? page + 1 : nil
                
				return DTOFetchPageResult(
                    items: response.results,
                    hasMore: response.next != nil,
                    nextPage: nextPage
                )
            },
            loadFromCache: {
				try self.cacheService.load(forKey: currentCacheKey) as DTOFetchPageResult<DTO>
            },
			saveToCache: { (result: DTOFetchPageResult<DTO>) in
                try self.cacheService.save(result, forKey: currentCacheKey)
            }
        )

		return RepositoryFetchResult<T>(
			items: mapDTOList(dtoResult.items),
			hasMore: dtoResult.hasMore,
			nextPage: dtoResult.nextPage
		)
    }
    
	func fetchDetail(
		endpoint: APIEndpoint,
		id: Int,
		cacheKey: String
	) async throws -> T {
		let dto = try await fetchWithCache(
            forceFetch: false,
            cacheKey: cacheKey,
            fetchFromAPI: {
				try await self.apiService.fetch(endpoint: endpoint, page: 1)
            },
            loadFromCache: {
				try self.cacheService.load(forKey: cacheKey)
            },
            saveToCache: { (item: DTO) in
                try self.cacheService.save(item, forKey: cacheKey)
            }
        )
		return self.mapDTO(dto)
    }
    
	func fetchByURL(url: String, cacheKey: String) async throws -> T {
        let dto = try await fetchWithCache(
            forceFetch: false,
            cacheKey: cacheKey,
            fetchFromAPI: {
                return try await self.apiService.fetchByURL(url: url)
            },
            loadFromCache: {
                return try self.cacheService.load(forKey: cacheKey)
            },
			saveToCache: { (item: DTO) in
                try self.cacheService.save(item, forKey: cacheKey)
            }
        )
		return self.mapDTO(dto)
    }
    
    // MARK: - Private Methods
    private func fetchWithCache<R: Codable>(
        forceFetch: Bool,
        cacheKey: String,
        fetchFromAPI: () async throws -> R,
        loadFromCache: () throws -> R,
        saveToCache: (R) throws -> Void
	) async throws -> R  {
        // If we're offline and not forcing a fetch, try to get from cache first
        let isOnline = connectivityService.isConnected
        if !isOnline && !forceFetch {
            do {
                return try loadFromCache()
            } catch {
                throw RepositoryError.noInternetNoCache
            }
        }
        
        // If we're forcing a fetch, or the cache doesn't exist, fetch from API
        if forceFetch || !cacheService.exists(forKey: cacheKey) {
            do {
                let result = try await fetchFromAPI()
                try saveToCache(result)
                return result
            } catch {
                // If fetching fails but we have cached data, use that as a fallback
                if cacheService.exists(forKey: cacheKey) {
                    do {
                        return try loadFromCache()
                    } catch {
                        // If even reading the cache fails, throw the original error
                        throw error
                    }
                }
                throw error
            }
        }
        
        // Otherwise, try the cache first
        do {
            return try loadFromCache()
        } catch {
            // If cache fails, try fetching instead
            do {
                let result = try await fetchFromAPI()
                try saveToCache(result)
                return result
            } catch {
                throw error
            }
        }
    }
}
