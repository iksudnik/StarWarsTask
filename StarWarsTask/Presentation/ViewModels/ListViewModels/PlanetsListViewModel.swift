//
//  PlanetsListViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import Domain
import SwiftUI

final class PlanetsListViewModel: BaseListViewModel<Planet> {
	private let repository: PlanetsRepositoryProtocol

	init(
		repository: PlanetsRepositoryProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
		self.repository = repository

		super.init(connectivityService: connectivityService)
	}

	override func loadPage(_ page: Int, forceFetch: Bool = false) async {
		let shouldReset = page == 1
		
		do {
			let result = try await repository.fetchPlanets(page: page, forceFetch: forceFetch)
			handleLoadResult(result: .success(result), reset: shouldReset)
		} catch {
			handleLoadResult(result: .failure(error), reset: shouldReset)
		}
	}
}
