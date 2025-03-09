//
//  FilmDetailView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

struct FilmDetailView: View {
	@ObservedObject var viewModel: FilmDetailViewModel
	@EnvironmentObject var container: DependencyContainer

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 16) {
				filmInfoSection

				if !viewModel.supportedRelatedTypes.isEmpty {
					RelatedItemsTabs(selectedTab: $viewModel.selectedTab, tabs: viewModel.tabTitles)
					if viewModel.isLoadingRelated {
						CentralLoaderView()
					} else {
						tabsContent
					}
				}
			}
			.padding()
		}
		.navigationTitle(viewModel.title)
		.navigationBarTitleDisplayMode(.large)
		.task {
			await viewModel.loadRelatedData()
		}
	}
}

// MARK: - UI Components
private extension FilmDetailView {

	var filmInfoSection: some View {
		VStack(alignment: .leading, spacing: 8) {
			DetailInfoSection(title: Localized.Details.basicInfo) {
				DetailInfoRow(label: Localized.Details.name, value: viewModel.title)
				DetailInfoRow(label: Localized.Film.episodeId, value: viewModel.episodeId.description)
				DetailInfoRow(label: Localized.Film.director, value: viewModel.director)
				DetailInfoRow(label: Localized.Film.producer, value: viewModel.producer)
				DetailInfoRow(label: Localized.Film.releaseDate, value: viewModel.releaseDate)
			}

			DetailInfoSection(title: Localized.Film.openingCrawl) {
				Text(viewModel.openingCrawl)
					.font(.body)
					.foregroundColor(.secondary)
			}
		}
	}

	@ViewBuilder
	var tabsContent: some View {
		let resourceType = viewModel.supportedRelatedTypes[viewModel.selectedTab]
		
		switch resourceType {
		case .person:
			RelatedItemsList(
				items: viewModel.filmCharacters,
				rowContent: { RowContentFactory.makePersonRow(for: $0) },
				destinationView: { person in
					PersonDetailView(viewModel: container.viewModelFactory.makePersonDetailViewModel(person: person))
				},
				emptyText: resourceType.emptyText
			)
			
		case .planet:
			RelatedItemsList(
				items: viewModel.filmPlanets,
				rowContent: { RowContentFactory.makePlanetRow(for: $0) },
				destinationView: { planet in
					PlanetDetailView(viewModel: container.viewModelFactory.makePlanetDetailViewModel(planet: planet))
				},
				emptyText: resourceType.emptyText
			)
			
		case .starship:
			RelatedItemsList(
				items: viewModel.filmStarships,
				rowContent: { RowContentFactory.makeStarshipRow(for: $0) },
				destinationView: { starship in
					StarshipDetailView(viewModel: container.viewModelFactory.makeStarshipDetailViewModel(starship: starship))
				},
				emptyText: resourceType.emptyText
			)
			
		case .vehicle:
			RelatedItemsList(
				items: viewModel.filmVehicles,
				rowContent: { RowContentFactory.makeVehicleRow(for: $0) },
				destinationView: { vehicle in
					VehicleDetailView(viewModel: container.viewModelFactory.makeVehicleDetailViewModel(vehicle: vehicle))
				},
				emptyText: resourceType.emptyText
			)
			
		case .species:
			RelatedItemsList(
				items: viewModel.filmSpecies,
				rowContent: { RowContentFactory.makeSpeciesRow(for: $0) },
				destinationView: { species in
					SpeciesDetailView(viewModel: container.viewModelFactory.makeSpeciesDetailViewModel(species: species))
				},
				emptyText: resourceType.emptyText
			)
			
		default:
			EmptyView()
		}
	}
}

//MARK: - Preview
#Preview {
	let container = DependencyContainer.preview

	let viewModel = container.viewModelFactory.makeFilmDetailViewModel(film: .preview)

	return NavigationView {
		FilmDetailView(viewModel: viewModel)
			.environmentObject(container)
	}
	.preferredColorScheme(.dark)
}
