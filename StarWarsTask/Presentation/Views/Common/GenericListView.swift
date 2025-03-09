//
//  GenericListView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

struct GenericListView<T, RowContent: View, DetailView: View>: View where T: Identifiable, T: Codable {
    @ObservedObject var viewModel: BaseListViewModel<T>
    
    let title: String
    let rowContent: (T) -> RowContent
    let detailView: (T) -> DetailView
    
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
                        NavigationLink(destination: detailView(item)) {
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

	GenericListView(viewModel: viewModel, title: "Films") { film in
		Text(film.title)
	} detailView: { _ in
		EmptyView()
	}
	.preferredColorScheme(.dark)
}

#Preview("Error") {
	let connectivityService = MockConnectivityService(isConnected: false)
	let repository = MockFilmsRepositoryNoInternetNoCache()
	let viewModel = FilmsListViewModel(
		repository: repository,
		connectivityService: connectivityService
	)

	GenericListView(viewModel: viewModel, title: "Films") { film in
		Text(film.title)
	} detailView: { _ in
		EmptyView()
	}
	.preferredColorScheme(.dark)
}
