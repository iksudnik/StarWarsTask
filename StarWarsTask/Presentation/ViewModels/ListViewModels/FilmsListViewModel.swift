//
//  FilmsListViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Core
import SwiftUI

final class FilmsListViewModel: BaseListViewModel<Film> {
    private let repository: FilmsRepositoryProtocol

	init(
		repository: FilmsRepositoryProtocol,
		connectivityService: ConnectivityServiceProtocol
	) {
        self.repository = repository

		super.init(connectivityService: connectivityService)
    }

	override func loadPage(_ page: Int, forceFetch: Bool = false) async {
		let shouldReset = page == 1

		do {
			let result = try await repository.fetchFilms(page: page, forceFetch: forceFetch)
			handleLoadResult(result: .success(result), reset: shouldReset)
		} catch {
			handleLoadResult(result: .failure(error), reset: shouldReset)
		}
	}
}
