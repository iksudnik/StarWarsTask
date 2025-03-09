//
//  StarWarsTaskApp.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import SwiftUI

@main
struct StarWarsTaskApp: App {

	init() {
		// Star Wars style appearance setup
		configureAppearance()
	}
	
    var body: some Scene {
        WindowGroup {
			DashboardView()
				.environmentObject(DependencyContainer())
				.preferredColorScheme(.dark) // Force dark theme to look more in StarWars style
        }
    }
}

// MARK: - Appearance
private extension StarWarsTaskApp {
	func configureAppearance() {
		// NavigationBar appearance setup
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.configureWithOpaqueBackground()
		navBarAppearance.backgroundColor = .systemBackground

		let tintColor = UIColor(AppColors.accent)

		navBarAppearance.titleTextAttributes = [
			.foregroundColor: tintColor,
			.font: UIFont.systemFont(ofSize: 18, weight: .bold)
		]
		navBarAppearance.largeTitleTextAttributes = [
			.foregroundColor: tintColor,
			.font: UIFont.systemFont(ofSize: 34, weight: .bold)
		]

		navBarAppearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: tintColor]
		navBarAppearance.buttonAppearance.highlighted.titleTextAttributes = [.foregroundColor: tintColor]
		navBarAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: tintColor]

		navBarAppearance.setBackIndicatorImage(
			UIImage(systemName: "chevron.left")?.withTintColor(tintColor, renderingMode: .alwaysOriginal),
			transitionMaskImage: UIImage(systemName: "chevron.left")?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
		)

		UINavigationBar.appearance().standardAppearance = navBarAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
		UINavigationBar.appearance().compactAppearance = navBarAppearance
		UINavigationBar.appearance().compactScrollEdgeAppearance = navBarAppearance

		UINavigationBar.appearance().tintColor = tintColor
	}
}
