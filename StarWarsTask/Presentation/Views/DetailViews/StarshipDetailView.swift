//
//  StarshipDetailView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

struct StarshipDetailView: View {
	@ObservedObject var viewModel: StarshipDetailViewModel
	@EnvironmentObject var container: DependencyContainer
	@EnvironmentObject var router: Router
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 16) {
				starshipInfoSection
				
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
private extension StarshipDetailView {
	
	var starshipInfoSection: some View {
		VStack(alignment: .leading, spacing: 8) {
			DetailInfoSection(title: Localized.Details.basicInfo) {
				DetailInfoRow(label: Localized.Details.name, value: viewModel.name)
				DetailInfoRow(label: Localized.Starship.model, value: viewModel.model)
				DetailInfoRow(label: Localized.Starship.manufacturer, value: viewModel.manufacturer)
				DetailInfoRow(label: Localized.Starship.starshipClass, value: viewModel.starshipClass)
			}
			
			DetailInfoSection(title: Localized.Details.technicalSpecs) {
				DetailInfoRow(label: Localized.Starship.length, value: "\(viewModel.length) \(Localized.Units.meters)")
				DetailInfoRow(label: Localized.Starship.crew, value: viewModel.crew)
				DetailInfoRow(label: Localized.Starship.passengers, value: viewModel.passengers)
				DetailInfoRow(label: Localized.Starship.maxSpeed, value: viewModel.maxAtmospheringSpeed)
				DetailInfoRow(label: Localized.Starship.hyperdrive, value: viewModel.hyperdriveRating)
				DetailInfoRow(label: Localized.Starship.mglt, value: viewModel.MGLT)
			}
			
			DetailInfoSection(title: Localized.Details.economicInfo) {
				DetailInfoRow(label: Localized.Starship.cost, value: "\(viewModel.costInCredits) \(Localized.Units.credits)")
				DetailInfoRow(label: Localized.Starship.cargoCapacity, value: viewModel.cargoCapacity)
				DetailInfoRow(label: Localized.Starship.consumables, value: viewModel.consumables)
			}
		}
	}
	
	@ViewBuilder
	var tabsContent: some View {
		let resourceType = viewModel.supportedRelatedTypes[viewModel.selectedTab]
		
		switch resourceType {
		case .person:
			RelatedItemsList(
				items: viewModel.starshipPilots,
				rowContent: { RowContentFactory.makePersonRow(for: $0) },
				onItemSelected: { person in
					router.navigateToDetail(for: person, resourceType: .person)
				},
				emptyText: resourceType.emptyText
			)
			
		case .film:
			RelatedItemsList(
				items: viewModel.starshipFilms,
				rowContent: { RowContentFactory.makeFilmRow(for: $0) },
				onItemSelected: { film in
					router.navigateToDetail(for: film, resourceType: .film)
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
	let viewModel = container.viewModelFactory.makeStarshipDetailViewModel(starship: .preview)

	return NavigationView {
		StarshipDetailView(viewModel: viewModel)
	}
	.environmentObject(container)
	.environmentObject(Router())
	.preferredColorScheme(.dark)
}
