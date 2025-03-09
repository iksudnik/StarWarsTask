//
//  VehiclesListView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

struct VehiclesListView: View {
    @EnvironmentObject var container: DependencyContainer
    @StateObject var viewModel: VehiclesListViewModel
    
    var body: some View {
        GenericListView(
            viewModel: viewModel,
            title: Localized.Vehicle.title,
            rowContent: { vehicle in
				RowContentFactory.makeVehicleRow(for: vehicle)
            },
            detailView: { vehicle in
				VehicleDetailView(viewModel: container.viewModelFactory.makeVehicleDetailViewModel(vehicle: vehicle))
            }
        )
    }
}

//MARK: - Preview
#Preview {
	let container = DependencyContainer.preview

	let viewModel = container.viewModelFactory.makeVehiclesListViewModel()

	return NavigationView {
		VehiclesListView(viewModel: viewModel)
	}
	.environmentObject(container)
	.preferredColorScheme(.dark)
}
