//
//  VehiclesRepositoryProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation
import Core

protocol VehiclesRepositoryProtocol {
    func fetchVehicles(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Vehicle>
    func fetchVehicle(id: Int) async throws -> Vehicle
    func fetchVehicleByURL(url: String) async throws -> Vehicle
}

final class VehiclesRepository: VehiclesRepositoryProtocol {
    private let genericRepository: BaseRepository<VehicleDTO, Vehicle>
    
    private let vehiclesListCacheKey = "vehicles_list"
    private func vehicleCacheKey(id: Int) -> String {
        return "vehicle_\(id)"
    }
    private func vehicleURLCacheKey(url: String) -> String {
        return "vehicle_url_\(url.hashValue)"
    }
    
	init(
		apiService: APIServiceProtocol,
		cacheService: StorageServiceProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
        self.genericRepository = BaseRepository<VehicleDTO, Vehicle>(
            apiService: apiService,
            cacheService: cacheService,
			connectivityService: connectivityService,
            mapDTO: { dto in
				ModelMapper.mapVehicle(dto)
            },
            mapDTOList: { dtoList in
                ModelMapper.mapVehicles(dtoList)
            }
        )
    }
    
    func fetchVehicles(page: Int, forceFetch: Bool) async throws -> RepositoryFetchResult<Vehicle> {
        let result = try await genericRepository.fetchList(
            endpoint: .vehicles,
            page: page,
			cacheKey: vehiclesListCacheKey,
			forceFetch: forceFetch
        )
		return .init(items: result.items, hasMore: result.hasMore, nextPage: result.nextPage)
    }
    
    func fetchVehicle(id: Int) async throws -> Vehicle {
        return try await genericRepository.fetchDetail(
            endpoint: .vehicleDetail(id: id),
            id: id,
            cacheKey: vehicleCacheKey(id: id)
        )
    }
    
    func fetchVehicleByURL(url: String) async throws -> Vehicle {
        return try await genericRepository.fetchByURL(
            url: url,
            cacheKey: vehicleURLCacheKey(url: url)
        )
    }
} 
