//
//  SpeciesListView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//


import SwiftUI

struct SpeciesListView: View {
    @EnvironmentObject var container: DependencyContainer
    @StateObject var viewModel: SpeciesListViewModel
    
    var body: some View {
        GenericListView(
            viewModel: viewModel,
            title: Localized.Species.title,
            rowContent: { species in
				RowContentFactory.makeSpeciesRow(for: species)
            },
            detailView: { species in
				SpeciesDetailView(viewModel: container.viewModelFactory.makeSpeciesDetailViewModel(species: species))
            }
        )
    }
}

//MARK: - Preview
#Preview {
	let container = DependencyContainer.preview

	let viewModel = container.viewModelFactory.makeSpeciesListViewModel()

	return NavigationView {
		SpeciesListView(viewModel: viewModel)
	}
	.environmentObject(container)
	.preferredColorScheme(.dark)
}
