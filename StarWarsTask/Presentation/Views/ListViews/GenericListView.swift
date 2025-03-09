//
//  GenericListView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

struct GenericListView<T: Hashable & Identifiable, RowContent: View>: View {
    @ObservedObject var viewModel: BaseListViewModel<T>
    @EnvironmentObject var router: Router
    
    let title: String
    let rowContent: (T) -> RowContent
    let resourceType: ResourceType
    
    var body: some View {
        LoadingStateView(
            state: viewModel.loadingState,
            retryAction: {
                Task {
                    await viewModel.loadItems()
                }
            },
            content: { items in
                List {
                    ForEach(items) { item in
                        Button {
                            router.navigateToDetail(for: item, resourceType: resourceType)
                        } label: {
                            rowContent(item)
                        }
                    }
                    
                    if viewModel.hasMorePages {
						CentralLoaderView()
                            .onAppear {
                                if !viewModel.isLoadingMore {
                                    Task {
                                        await viewModel.loadMoreItems()
                                    }
                                }
                            }
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    await viewModel.refresh()
                }
            }
        )
        .navigationTitle(title)
		.navigationBarTitleDisplayMode(.large)
    }
}


//MARK: - Preview
#Preview("Normal") {
	let connectivityService = MockConnectivityService()
	let repository = MockFilmsRepository()
	let viewModel = FilmsListViewModel(
		repository: repository,
		connectivityService: connectivityService
	)

	GenericListView(
        viewModel: viewModel, 
        title: "Films",
        rowContent: { Text($0.title) },
        resourceType: .film
    )
    .environmentObject(Router())
	.preferredColorScheme(.dark)
}

#Preview("Error") {
	let connectivityService = MockConnectivityService(isConnected: false)
	let repository = MockFilmsRepositoryNoInternetNoCache()
	let viewModel = FilmsListViewModel(
		repository: repository,
		connectivityService: connectivityService
	)

	GenericListView(
		viewModel: viewModel,
		title: "Films",
		rowContent: { Text($0.title) },
		resourceType: .film
	)
	.environmentObject(Router())
	.preferredColorScheme(.dark)
}
