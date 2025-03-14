//
//  PeopleListView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import SwiftUI

struct PeopleListView: View {
    @EnvironmentObject var container: DependencyContainer
    @StateObject var viewModel: PeopleListViewModel
    
    var body: some View {
        GenericListView(
            viewModel: viewModel,
            title: Localized.Character.title,
            rowContent: { person in
				RowContentFactory.makePersonRow(for: person)
            },
            resourceType: .person
        )
    }
}

//MARK: - Preview
#Preview {
    let container = DependencyContainer.preview
    
	let viewModel = container.viewModelFactory.makePeopleListViewModel()

    return NavigationView {
        PeopleListView(viewModel: viewModel)
    }
	.environmentObject(container)
	.environmentObject(Router())
	.preferredColorScheme(.dark)
}
