//
//  SpeciesListViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Foundation
import SwiftUI

class SpeciesListViewModel: BaseListViewModel<Species> {
	private let repository: SpeciesRepositoryProtocol

	init(
		repository: SpeciesRepositoryProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
		self.repository = repository

		super.init(connectivityService: connectivityService)
	}

	override func loadPage(_ page: Int, forceFetch: Bool = false) async {
		let shouldReset = page == 1

		do {
			let result = try await repository.fetchSpecies(page: page, forceFetch: forceFetch)
			handleLoadResult(result: .success(result), reset: shouldReset)
		} catch {
			handleLoadResult(result: .failure(error), reset: shouldReset)
		}
	}
}
