//
//  StarshipsListView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

struct StarshipsListView: View {
    @EnvironmentObject var container: DependencyContainer
    @StateObject var viewModel: StarshipsListViewModel
    
    var body: some View {
        GenericListView(
            viewModel: viewModel,
            title: Localized.Starship.title,
            rowContent: { starship in
				RowContentFactory.makeStarshipRow(for: starship)
            },
            resourceType: .starship
        )
    }
}

//MARK: - Preview
#Preview {
	let container = DependencyContainer.preview

	let viewModel = container.viewModelFactory.makeStarshipsListViewModel()

	return NavigationView {
		StarshipsListView(viewModel: viewModel)
	}
	.environmentObject(container)
	.environmentObject(Router())
	.preferredColorScheme(.dark)
}
