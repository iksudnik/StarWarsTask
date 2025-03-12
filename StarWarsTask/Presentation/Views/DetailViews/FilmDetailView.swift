//
//  FilmDetailView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Core
import SwiftUI

struct FilmDetailView: View {
	@ObservedObject var viewModel: FilmDetailViewModel
	@EnvironmentObject var container: DependencyContainer
	@EnvironmentObject var router: Router
	
	@State private var showCrawl = false

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
		.sheet(isPresented: $showCrawl) {
			OpeningCrawlView(
				text: viewModel.openingCrawl)
		}
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

			openingCrawlButton
		}
	}

	var openingCrawlButton: some View {
		HStack {
			Spacer()

			Button(action: {
				showCrawl = true
			}) {
				HStack {
					Image(systemName: "play.fill")
					Text(Localized.UI.watchOpeningCrawl)
				}
				.padding(.vertical, 8)
				.padding(.horizontal, 16)
				.background(AppColors.accent)
				.foregroundColor(.black)
				.cornerRadius(8)
			}
			.padding(.top, 12)
			
			Spacer()
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
				onItemSelected: { person in
					router.navigateToDetail(for: person, resourceType: .person)
				},
				emptyText: resourceType.emptyText
			)
			
		case .planet:
			RelatedItemsList(
				items: viewModel.filmPlanets,
				rowContent: { RowContentFactory.makePlanetRow(for: $0) },
				onItemSelected: { planet in
					router.navigateToDetail(for: planet, resourceType: .planet)
				},
				emptyText: resourceType.emptyText
			)
			
		case .starship:
			RelatedItemsList(
				items: viewModel.filmStarships,
				rowContent: { RowContentFactory.makeStarshipRow(for: $0) },
				onItemSelected: { starship in
					router.navigateToDetail(for: starship, resourceType: .starship)
				},
				emptyText: resourceType.emptyText
			)
			
		case .vehicle:
			RelatedItemsList(
				items: viewModel.filmVehicles,
				rowContent: { RowContentFactory.makeVehicleRow(for: $0) },
				onItemSelected: { vehicle in
					router.navigateToDetail(for: vehicle, resourceType: .vehicle)
				},
				emptyText: resourceType.emptyText
			)
			
		case .species:
			RelatedItemsList(
				items: viewModel.filmSpecies,
				rowContent: { RowContentFactory.makeSpeciesRow(for: $0) },
				onItemSelected: { species in
					router.navigateToDetail(for: species, resourceType: .species)
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
	}
	.environmentObject(container)
	.environmentObject(Router())
	.preferredColorScheme(.dark)
}
