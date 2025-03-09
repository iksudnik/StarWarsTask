//
//  BaseListViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

/// Base class for all list view models
@MainActor
class BaseListViewModel<T>: ObservableObject where T: Identifiable, T: Codable {
    @Published var items: [T] = []
    @Published var isLoadingMore = false
    @Published var hasMorePages = false
    @Published var loadingState: LoadingState<[T]> = .loading

	@Published var isOfflineMode = false

    private(set) var nextPage: Int?

	let connectivityService: ConnectivityServiceProtocol

	init(connectivityService: ConnectivityServiceProtocol) {
		self.connectivityService = connectivityService

		self.isOfflineMode = !connectivityService.isConnected

		subscribeToConnectivityChanges()

		Task {
			await loadItems()
		}
	}

	func loadPage(_ page: Int, forceFetch: Bool = false) async {
		fatalError("Should be overridden")
	}

	final func loadItems(forceFetch: Bool = false) async {
		loadingState = .loading

		await loadPage(1, forceFetch: forceFetch)
    }

	final func loadMoreItems() async {
		guard hasMorePages, !isLoadingMore, let nextPage = nextPage else { return }

		isLoadingMore = true
		defer { isLoadingMore = false }

		await loadPage(nextPage)
	}

    final func refresh() async {
        await loadItems(forceFetch: true)
    }
    
	final func handleLoadResult(
		result: Result<RepositoryFetchResult<T>, Error>,
		reset: Bool
	) { 
        switch result {
        case .success(let loadResult):
            if reset {
                items = loadResult.items
            } else {
                items.append(contentsOf: loadResult.items)
            }
            loadingState = items.isEmpty ? .empty : .loaded(items)
            hasMorePages = loadResult.hasMore
            nextPage = loadResult.nextPage
            
        case .failure(let loadError):
            if reset {
                loadingState = .error(loadError)
            } else {
                print("Error loading more items: \(loadError.localizedDescription)")
            }
        }
    }

	private func subscribeToConnectivityChanges() {
		Task { @MainActor in
			for await isConnected in connectivityService.connectivityUpdates {
				isOfflineMode = !isConnected
			}
		}
	}
}
