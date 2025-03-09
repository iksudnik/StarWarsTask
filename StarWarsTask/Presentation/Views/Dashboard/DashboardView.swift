//
//  DashboardView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var container: DependencyContainer
    @State private var selectedCategory: ResourceType?
    
    private let columns = [
		GridItem(
			.adaptive(minimum: 150, maximum: 180),
			spacing: 20
		)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title banner
                    VStack {
                        Text(Localized.Titles.starWarsHeader)
                            .font(.largeTitle)
                            .fontWeight(.black)
							.foregroundColor(AppColors.accent)
                            .padding(.top)
                        
						Text(Localized.Titles.byJakala)
                            .font(.headline)
                            .foregroundColor(AppColors.accent.opacity(0.8))
                            .padding(.bottom)
                    }
                    .frame(maxWidth: .infinity)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(ResourceType.allCasesOrdered, id: \.self) { category in
                            NavigationLink(value: category) {
                                CategoryGridItem(resourceType: category)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(
                AppColors.background
                    .ignoresSafeArea()
            )
            .navigationDestination(for: ResourceType.self) { category in
                switch category {
                case .person:
                    PeopleListView(viewModel: container.viewModelFactory.makePeopleListViewModel())
                case .planet:
                    PlanetsListView(viewModel: container.viewModelFactory.makePlanetsListViewModel())
                case .starship:
                    StarshipsListView(viewModel: container.viewModelFactory.makeStarshipsListViewModel())
                case .vehicle:
                    VehiclesListView(viewModel: container.viewModelFactory.makeVehiclesListViewModel())
                case .species:
                    SpeciesListView(viewModel: container.viewModelFactory.makeSpeciesListViewModel())
                case .film:
                    FilmsListView(viewModel: container.viewModelFactory.makeFilmsListViewModel())
                }
            }
        }
    }
}

// MARK: - ResourceType
private extension ResourceType {
	static var allCasesOrdered: [ResourceType] {
		return [.film, .planet, .person, .starship, .vehicle, .species]
	}
}


// MARK: - Preview
#Preview {
    DashboardView()
		.environmentObject(DependencyContainer.preview)
        .preferredColorScheme(.dark)
} 
