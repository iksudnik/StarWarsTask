//
//  PlanetsListView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

struct PlanetsListView: View {
    @EnvironmentObject var container: DependencyContainer
    @StateObject var viewModel: PlanetsListViewModel

    var body: some View {
        GenericListView(
            viewModel: viewModel,
            title: Localized.Planet.title,
            rowContent: { planet in
				RowContentFactory.makePlanetRow(for: planet)
            },
            detailView: { planet in
				PlanetDetailView(viewModel: container.viewModelFactory.makePlanetDetailViewModel(planet: planet))
            }
        )
    }
}

//MARK: - Preview
#Preview {
	let container = DependencyContainer.preview

	let viewModel = container.viewModelFactory.makePlanetsListViewModel()

	return NavigationView {
		PlanetsListView(viewModel: viewModel)
	}
	.environmentObject(container)
	.preferredColorScheme(.dark)
}
