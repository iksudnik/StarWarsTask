//
//  SpeciesListView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
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
            resourceType: .species
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
	.environmentObject(Router())
	.preferredColorScheme(.dark)
}
