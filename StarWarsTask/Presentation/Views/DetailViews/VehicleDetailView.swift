//
//  VehicleDetailView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

struct VehicleDetailView: View {
	@ObservedObject var viewModel: VehicleDetailViewModel
	@EnvironmentObject var container: DependencyContainer
	@EnvironmentObject var router: Router
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 16) {
				vehicleInfoSection
				
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
private extension VehicleDetailView {
	
	var vehicleInfoSection: some View {
		VStack(alignment: .leading, spacing: 8) {
			DetailInfoSection(title: Localized.Details.basicInfo) {
				DetailInfoRow(label: Localized.Details.name, value: viewModel.name)
				DetailInfoRow(label: Localized.Vehicle.model, value: viewModel.model)
				DetailInfoRow(label: Localized.Vehicle.manufacturer, value: viewModel.manufacturer)
				DetailInfoRow(label: Localized.Vehicle.vehicleClass, value: viewModel.vehicleClass)
			}
			
			DetailInfoSection(title: Localized.Details.technicalSpecs) {
				DetailInfoRow(label: Localized.Vehicle.length, value: "\(viewModel.length) \(Localized.Units.meters)")
				DetailInfoRow(label: Localized.Vehicle.crew, value: viewModel.crew)
				DetailInfoRow(label: Localized.Vehicle.passengers, value: viewModel.passengers)
				DetailInfoRow(label: Localized.Vehicle.maxSpeed, value: viewModel.maxAtmospheringSpeed)
			}
			
			DetailInfoSection(title: Localized.Details.economicInfo) {
				DetailInfoRow(label: Localized.Vehicle.cost, value: "\(viewModel.costInCredits) \(Localized.Units.credits)")
				DetailInfoRow(label: Localized.Vehicle.cargoCapacity, value: viewModel.cargoCapacity)
				DetailInfoRow(label: Localized.Vehicle.consumables, value: viewModel.consumables)
			}
		}
	}
	
	@ViewBuilder
	var tabsContent: some View {
		let resourceType = viewModel.supportedRelatedTypes[viewModel.selectedTab]
		
		switch resourceType {
		case .person:
			RelatedItemsList(
				items: viewModel.vehiclePilots,
				rowContent: { RowContentFactory.makePersonRow(for: $0) },
				onItemSelected: { person in
					router.navigateToDetail(for: person, resourceType: .person)
				},
				emptyText: resourceType.emptyText
			)
			
		case .film:
			RelatedItemsList(
				items: viewModel.vehicleFilms,
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
	let viewModel = container.viewModelFactory.makeVehicleDetailViewModel(vehicle: .preview)

	return NavigationView {
		VehicleDetailView(viewModel: viewModel)
	}
	.environmentObject(container)
	.environmentObject(Router())
	.preferredColorScheme(.dark)
}
