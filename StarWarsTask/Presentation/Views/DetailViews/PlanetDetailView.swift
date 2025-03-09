//
//  PlanetDetailView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

struct PlanetDetailView: View {
	@ObservedObject var viewModel: PlanetDetailViewModel
	@EnvironmentObject var container: DependencyContainer

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 16) {
				planetInfoSection

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
		.navigationTitle(viewModel.name)
		.navigationBarTitleDisplayMode(.large)
		.task {
			await viewModel.loadRelatedData()
		}
	}
}

// MARK: - UI Components
private extension PlanetDetailView {
	
	var planetInfoSection: some View {
		VStack(alignment: .leading, spacing: 8) {
			DetailInfoSection(title: Localized.Details.basicInfo) {
				DetailInfoRow(label: Localized.Details.name, value: viewModel.name)
				DetailInfoRow(label: Localized.Planet.population, value: viewModel.population)
				DetailInfoRow(label: Localized.Planet.climate, value: viewModel.climate)
				DetailInfoRow(label: Localized.Planet.terrain, value: viewModel.terrain)
			}
			
			DetailInfoSection(title: Localized.Planet.orbitalInfo) {
				DetailInfoRow(label: Localized.Planet.diameter, value: "\(viewModel.diameter) \(Localized.Units.km)")
				DetailInfoRow(label: Localized.Planet.gravity, value: viewModel.gravity)
				DetailInfoRow(label: Localized.Planet.rotationPeriod, value: "\(viewModel.rotationPeriod) \(Localized.Units.days)")
				DetailInfoRow(label: Localized.Planet.orbitalPeriod, value: "\(viewModel.orbitalPeriod) \(Localized.Units.days)")
				DetailInfoRow(label: Localized.Planet.surfaceWater, value: "\(viewModel.surfaceWater)\(Localized.Units.percent)")
			}
		}
	}
	
	@ViewBuilder
	var tabsContent: some View {
		let resourceType = viewModel.supportedRelatedTypes[viewModel.selectedTab]
		
		switch resourceType {
		case .person:
			RelatedItemsList(
				items: viewModel.planetResidents,
				rowContent: { RowContentFactory.makePersonRow(for: $0) },
				destinationView: { person in
					PersonDetailView(viewModel: container.viewModelFactory.makePersonDetailViewModel(person: person))
				},
				emptyText: resourceType.emptyText
			)
			
		case .film:
			RelatedItemsList(
				items: viewModel.planetFilms,
				rowContent: { RowContentFactory.makeFilmRow(for: $0) },
				destinationView: { film in
					FilmDetailView(viewModel: container.viewModelFactory.makeFilmDetailViewModel(film: film))
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

	let viewModel = container.viewModelFactory.makePlanetDetailViewModel(planet: .preview)

	return NavigationView {
		PlanetDetailView(viewModel: viewModel)
			.environmentObject(container)
	}
	.preferredColorScheme(.dark)
}
