//
//  MainNavigationView.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

struct MainNavigationView: View {
    @EnvironmentObject private var container: DependencyContainer
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            DashboardView()
                .navigationDestination(for: AppRoute.self) { route in
                    container.destinationBuilder.buildDestination(for: route)
                }
        }
        .environmentObject(router)
    }
} 


// MARK: - Preview
#Preview {
	MainNavigationView()
		.environmentObject(DependencyContainer.preview)
		.environmentObject(Router())
		.preferredColorScheme(.dark)
}
