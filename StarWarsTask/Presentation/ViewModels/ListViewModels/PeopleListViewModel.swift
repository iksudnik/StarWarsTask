//
//  PeopleListViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

final class PeopleListViewModel: BaseListViewModel<Person> {
    private let repository: PeopleRepositoryProtocol

    init(repository: PeopleRepositoryProtocol, connectivityService: ConnectivityServiceProtocol) {
        self.repository = repository

        super.init(connectivityService: connectivityService)
    }
    
	override func loadPage(_ page: Int, forceFetch: Bool = false) async {
		let shouldReset = page == 1

		do {
			let result = try await repository.fetchPeople(page: page, forceFetch: forceFetch)
			handleLoadResult(result: .success(result), reset: shouldReset)
		} catch {
			handleLoadResult(result: .failure(error), reset: shouldReset)
		}
	}
}
