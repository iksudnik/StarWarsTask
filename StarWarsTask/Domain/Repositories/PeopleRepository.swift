//
//  PeopleRepositoryProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

protocol PeopleRepositoryProtocol {
    func fetchPeople(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Person>
    func fetchPerson(id: Int) async throws -> Person
    func fetchPersonByURL(url: String) async throws -> Person
}

final class PeopleRepository: PeopleRepositoryProtocol {
    private let genericRepository: BaseRepository<PersonDTO, Person>
    
    private let peopleListCacheKey = "people_list"
    private func personCacheKey(id: Int) -> String {
        return "person_\(id)"
    }
    private func personURLCacheKey(url: String) -> String {
        return "person_url_\(url.hashValue)"
    }
    
	init(
		apiService: APIServiceProtocol,
		cacheService: StorageServiceProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
        self.genericRepository = BaseRepository<PersonDTO, Person>(
            apiService: apiService,
            cacheService: cacheService,
			connectivityService: connectivityService,
            mapDTO: { dto in
				ModelMapper.mapPerson(dto)
            },
            mapDTOList: { dtoList in
				ModelMapper.mapPersons(dtoList)
            }
        )
    }
    
    func fetchPeople(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Person> {
        let result = try await genericRepository.fetchList(
            endpoint: .people,
            page: page,
            cacheKey: peopleListCacheKey,
            forceFetch: forceFetch
        )
		return .init(items: result.items, hasMore: result.hasMore, nextPage: result.nextPage)
    }
    
    func fetchPerson(id: Int) async throws -> Person {
        return try await genericRepository.fetchDetail(
            endpoint: .personDetail(id: id),
            id: id,
            cacheKey: personCacheKey(id: id)
        )
    }
    
    func fetchPersonByURL(url: String) async throws -> Person {
        return try await genericRepository.fetchByURL(
            url: url,
            cacheKey: personURLCacheKey(url: url)
		)
    }
} 
