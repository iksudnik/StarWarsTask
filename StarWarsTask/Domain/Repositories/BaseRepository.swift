//
//  BaseRepositoryProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

/// Protocol for a generic repository that can work with any data type
protocol BaseRepositoryProtocol<T> {
    associatedtype T: Codable
    
    /// Fetches a list of objects with pagination support
	func fetchList(
		endpoint: APIEndpoint,
		page: Int,
		cacheKey: String,
		forceFetch: Bool
	) async throws ->  RepositoryFetchResult<T>

    /// Fetches a single object by ID
    func fetchDetail(endpoint: APIEndpoint, id: Int, cacheKey: String) async throws -> T
    
    /// Fetches a single object by URL
    func fetchByURL(url: String, cacheKey: String) async throws -> T
}

/// Structure for storing pagination information
private struct PaginationInfo: Codable {
	let totalCount: Int
	let hasNext: Bool
	let hasPrevious: Bool
	let nextPage: Int?
}


final class BaseRepository<T: Codable>: BaseRepositoryProtocol {
    private let apiService: APIServiceProtocol
    private let cacheService: StorageServiceProtocol
    private let connectivityService: ConnectivityServiceProtocol

	init(
		apiService: APIServiceProtocol,
		cacheService: StorageServiceProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
        self.apiService = apiService
        self.cacheService = cacheService
        self.connectivityService = connectivityService
    }
    
    // MARK: - Public Methods
	func fetchList(
		endpoint: APIEndpoint,
		page: Int = 1,
		cacheKey: String,
		forceFetch: Bool
	) async throws -> RepositoryFetchResult<T> {

		let currentCacheKey = "\(cacheKey)_page_\(page)"
        let paginationCacheKey = "\(currentCacheKey)_pagination"
        
        return try await fetchWithCache(
            forceFetch: forceFetch,
            cacheKey: currentCacheKey,
            fetchFromAPI: {
                let response: APIResponse<T> = try await self.apiService.fetch(endpoint: endpoint, page: page)

				// Determine if there's a next page and what its number is
                var nextPage: Int? = nil
                if let nextURLString = response.next, let nextURL = URL(string: nextURLString) {
                    let components = URLComponents(url: nextURL, resolvingAgainstBaseURL: false)
                    if let pageItem = components?.queryItems?.first(where: { $0.name == "page" }),
                       let pageString = pageItem.value,
                       let pageNumber = Int(pageString) {
                        nextPage = pageNumber
                    }
                }
                
                // Create pagination information
                let paginationInfo = PaginationInfo(
                    totalCount: response.count,
                    hasNext: response.next != nil,
                    hasPrevious: response.previous != nil,
                    nextPage: nextPage
                )
                
                // Save pagination information
                try? self.cacheService.save(paginationInfo, forKey: paginationCacheKey)
                
				return .init(items: response.results, hasMore: response.next != nil, nextPage: nextPage)
            },
            loadFromCache: {
                let items: [T] = try self.cacheService.load(forKey: currentCacheKey)

                var hasMore = false
                var nextPage: Int? = nil
                if self.cacheService.exists(forKey: paginationCacheKey) {
                    let paginationInfo: PaginationInfo = try self.cacheService.load(forKey: paginationCacheKey)
                    hasMore = paginationInfo.hasNext
                    nextPage = paginationInfo.nextPage
                }

				return .init(items: items, hasMore: hasMore, nextPage: nextPage)
            },
            saveToCache: { items in
                try self.cacheService.save(items.items, forKey: currentCacheKey)
            }
        )
    }
    
	func fetchDetail(
		endpoint: APIEndpoint,
		id: Int,
		cacheKey: String
	) async throws -> T {
        return try await fetchWithCache(
            forceFetch: false,
            cacheKey: cacheKey,
            fetchFromAPI: {
				let item: T = try await self.apiService.fetch(endpoint: endpoint, page: 1)
                return item
            },
            loadFromCache: {
                return try self.cacheService.load(forKey: cacheKey)
            },
            saveToCache: { item in
                try self.cacheService.save(item, forKey: cacheKey)
            }
        )
    }
    
    func fetchByURL(url: String, cacheKey: String) async throws -> T {
        return try await fetchWithCache(
            forceFetch: false,
            cacheKey: cacheKey,
            fetchFromAPI: {
                let item: T = try await self.apiService.fetchByURL(url: url)
                return item
            },
            loadFromCache: {
                return try self.cacheService.load(forKey: cacheKey)
            },
            saveToCache: { item in
                try self.cacheService.save(item, forKey: cacheKey)
            }
        )
    }
    
    // MARK: - Private Methods
    private func fetchWithCache<U>(
        forceFetch: Bool,
        cacheKey: String,
        fetchFromAPI: () async throws -> U,
        loadFromCache: () throws -> U,
        saveToCache: (U) throws -> Void
    ) async throws -> U {
        if !forceFetch && cacheService.exists(forKey: cacheKey) {
            do {
                return try loadFromCache()
            } catch {
                print("Warning: Failed to load from cache: \(error.localizedDescription)")
            }
        }
        
		if connectivityService.isConnected {
            do {
                let result = try await fetchFromAPI()
                
                do {
                    try saveToCache(result)
                } catch {
                    print("Warning: Failed to save to cache: \(error.localizedDescription)")
                }
                
                return result
            } catch let apiError {
                let parentError = RepositoryError.apiError(apiError.localizedDescription)
                return try loadFromCacheOrThrow(cacheKey: cacheKey, loadFromCache: loadFromCache, parentError: parentError)
            }
        } else {
			return try loadFromCacheOrThrow(cacheKey: cacheKey, loadFromCache: loadFromCache, parentError: nil)
        }
    }
    
    /// Attempts to load data from cache or throws an appropriate error
    private func loadFromCacheOrThrow<U>(
        cacheKey: String, 
        loadFromCache: () throws -> U, 
        parentError: Error?
    ) throws -> U {
        if cacheService.exists(forKey: cacheKey) {
            do {
                return try loadFromCache()
            } catch let cacheError {
                // If cache exists but there was an error loading from it
                throw RepositoryError.cacheError("Failed to load from cache: \(cacheError.localizedDescription)")
            }
        } else {
            throw parentError ?? RepositoryError.noInternetNoCache
        }
    }
}
