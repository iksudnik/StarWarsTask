//
//  PersonDetailView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

struct PersonDetailView: View {
	@ObservedObject var viewModel: PersonDetailViewModel
	@EnvironmentObject var container: DependencyContainer
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 16) {
				personInfoSection
				
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
private extension PersonDetailView {
	
	var personInfoSection: some View {
		VStack(alignment: .leading, spacing: 8) {
			DetailInfoSection(title: Localized.Details.basicInfo) {
				DetailInfoRow(label: Localized.Details.name, value: viewModel.name)
				DetailInfoRow(label: Localized.Character.gender, value: viewModel.gender)
				DetailInfoRow(label: Localized.Character.birthYear, value: viewModel.birthYear)
			}
			
			DetailInfoSection(title: Localized.Details.physicalTraits) {
				DetailInfoRow(label: Localized.Character.height, value: "\(viewModel.height) \(Localized.Units.cm)")
				DetailInfoRow(label: Localized.Character.weight, value: "\(viewModel.mass) \(Localized.Units.kg)")
				DetailInfoRow(label: Localized.Character.hairColor, value: viewModel.hairColor)
				DetailInfoRow(label: Localized.Character.skinColor, value: viewModel.skinColor)
				DetailInfoRow(label: Localized.Character.eyeColor, value: viewModel.eyeColor)
			}
		}
	}
	
	@ViewBuilder
	var tabsContent: some View {
		let resourceType = viewModel.supportedRelatedTypes[viewModel.selectedTab]
		
		switch resourceType {
		case .planet:
			if let homeworld = viewModel.homeworld {
				RelatedItemsList(
					items: [homeworld],
					rowContent: { RowContentFactory.makePlanetRow(for: $0) },
					destinationView: { planet in
						PlanetDetailView(viewModel: container.viewModelFactory.makePlanetDetailViewModel(planet: planet))
					},
					emptyText: resourceType.emptyText
				)
			} else {
				EmptyView()
			}
			
		case .starship:
			RelatedItemsList(
				items: viewModel.personStarships,
				rowContent: { RowContentFactory.makeStarshipRow(for: $0) },
				destinationView: { starship in
					StarshipDetailView(viewModel: container.viewModelFactory.makeStarshipDetailViewModel(starship: starship))
				},
				emptyText: resourceType.emptyText
			)
			
		case .vehicle:
			RelatedItemsList(
				items: viewModel.personVehicles,
				rowContent: { RowContentFactory.makeVehicleRow(for: $0) },
				destinationView: { vehicle in
					VehicleDetailView(viewModel: container.viewModelFactory.makeVehicleDetailViewModel(vehicle: vehicle))
				},
				emptyText: resourceType.emptyText
			)
			
		case .species:
			RelatedItemsList(
				items: viewModel.personSpecies,
				rowContent: { RowContentFactory.makeSpeciesRow(for: $0) },
				destinationView: { species in
					SpeciesDetailView(viewModel: container.viewModelFactory.makeSpeciesDetailViewModel(species: species))
				},
				emptyText: resourceType.emptyText
			)
			
		case .film:
			RelatedItemsList(
				items: viewModel.personFilms,
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

	let viewModel = container.viewModelFactory.makePersonDetailViewModel(person: .preview)

	return NavigationView {
		PersonDetailView(viewModel: viewModel)
			.environmentObject(container)
	}
	.preferredColorScheme(.dark)
}
