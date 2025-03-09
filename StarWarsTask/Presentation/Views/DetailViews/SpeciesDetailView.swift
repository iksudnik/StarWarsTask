//
//  SpeciesDetailView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

struct SpeciesDetailView: View {
    @ObservedObject var viewModel: SpeciesDetailViewModel
    @EnvironmentObject var container: DependencyContainer
    @EnvironmentObject var router: Router
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                speciesInfoSection
                
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
private extension SpeciesDetailView {
    
    var speciesInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            DetailInfoSection(title: Localized.Details.basicInfo) {
                DetailInfoRow(label: Localized.Details.name, value: viewModel.name)
                DetailInfoRow(label: Localized.Species.classification, value: viewModel.classification)
                DetailInfoRow(label: Localized.Species.designation, value: viewModel.designation)
                DetailInfoRow(label: Localized.Species.language, value: viewModel.language)
            }
            
            DetailInfoSection(title: Localized.Details.physicalTraits) {
                DetailInfoRow(label: Localized.Species.averageHeight, value: "\(viewModel.averageHeight) \(Localized.Units.cm)")
                DetailInfoRow(label: Localized.Species.averageLifespan, value: "\(viewModel.averageLifespan) \(Localized.Units.years)")
                DetailInfoRow(label: Localized.Species.skinColors, value: viewModel.skinColors)
                DetailInfoRow(label: Localized.Species.hairColors, value: viewModel.hairColors)
                DetailInfoRow(label: Localized.Species.eyeColors, value: viewModel.eyeColors)
            }
        }
    }
    
    @ViewBuilder
    var tabsContent: some View {
        let resourceType = viewModel.supportedRelatedTypes[viewModel.selectedTab]
        
        switch resourceType {
        case .person:
            RelatedItemsList(
                items: viewModel.relatedPeople,
                rowContent: { RowContentFactory.makePersonRow(for: $0) },
                onItemSelected: { person in
                    router.navigateToDetail(for: person, resourceType: .person)
                },
                emptyText: resourceType.emptyText
            )
            
        case .planet:
            if let homeworld = viewModel.homeworld {
                RelatedItemsList(
                    items: [homeworld],
                    rowContent: { RowContentFactory.makePlanetRow(for: $0) },
                    onItemSelected: { planet in
                        router.navigateToDetail(for: planet, resourceType: .planet)
                    },
                    emptyText: resourceType.emptyText
                )
            } else {
                EmptyView()
            }
            
        case .film:
            RelatedItemsList(
                items: viewModel.relatedFilms,
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

	let viewModel = container.viewModelFactory.makeSpeciesDetailViewModel(species: .preview)

	return NavigationView {
		SpeciesDetailView(viewModel: viewModel)
	}
	.environmentObject(container)
	.environmentObject(Router())
	.preferredColorScheme(.dark)
}
