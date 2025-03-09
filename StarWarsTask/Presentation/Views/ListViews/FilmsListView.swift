//
//  FilmsListView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

struct FilmsListView: View {
	@EnvironmentObject var container: DependencyContainer
    @StateObject var viewModel: FilmsListViewModel
    
    var body: some View {
        GenericListView(
            viewModel: viewModel,
            title: Localized.Film.title,
            rowContent: { film in
				RowContentFactory.makeFilmRow(for: film)
            },
            detailView: { film in
				FilmDetailView(viewModel: container.viewModelFactory.makeFilmDetailViewModel(film: film))
            }
        )
    }
}


//MARK: - Preview
#Preview {
	let container = DependencyContainer.preview
	let viewModel = container.viewModelFactory.makeFilmsListViewModel()

	return NavigationView {
		FilmsListView(viewModel: viewModel)
			.environmentObject(container)
	}
	.preferredColorScheme(.dark)

}
