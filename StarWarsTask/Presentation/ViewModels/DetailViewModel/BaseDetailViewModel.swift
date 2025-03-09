//
//  BaseDetailViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import SwiftUI

/// Base class for all detail view models
@MainActor
class BaseDetailViewModel: ObservableObject {
    @Published var isLoadingRelated = false
    @Published var selectedTab = 0
    
    @Published var relatedPeople: [Person] = []
    @Published var relatedPlanets: [Planet] = []
    @Published var relatedStarships: [Starship] = []
    @Published var relatedVehicles: [Vehicle] = []
    @Published var relatedSpecies: [Species] = []
    @Published var relatedFilms: [Film] = []

    var supportedRelatedTypes: [ResourceType] = []
    
    var tabTitles: [String] {
        return supportedRelatedTypes.map { $0.title }
    }
    
    var peopleRepository: PeopleRepositoryProtocol?
    var planetsRepository: PlanetsRepositoryProtocol?
    var starshipsRepository: StarshipsRepositoryProtocol?
    var vehiclesRepository: VehiclesRepositoryProtocol?
    var speciesRepository: SpeciesRepositoryProtocol?
    var filmsRepository: FilmsRepositoryProtocol?
    
    var peopleURLs: [String] = []
    var planetsURLs: [String] = []
    var starshipsURLs: [String] = []
    var vehiclesURLs: [String] = []
    var speciesURLs: [String] = []
    var filmsURLs: [String] = []
    
    func loadRelatedData() async {
        isLoadingRelated = true
        defer { isLoadingRelated = false }

        try? await performRelatedDataLoading()
    }
    
    func performRelatedDataLoading() async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in

			for type in supportedRelatedTypes {
                group.addTask {
                    try Task.checkCancellation()
                    
                    switch type {
                    case .person:
                        await self.loadRelatedPeople()
                    case .planet:
                        await self.loadRelatedPlanets()
                    case .starship:
                        await self.loadRelatedStarships()
                    case .vehicle:
                        await self.loadRelatedVehicles()
                    case .species:
                        await self.loadRelatedSpecies()
                    case .film:
                        await self.loadRelatedFilms()
                    }
                }
            }
            
            try await group.waitForAll()
        }
    }
} 

// MARK: - Helper methods for loading resources
private extension BaseDetailViewModel {
    func loadRelatedPeople() async {
        guard let repository = peopleRepository else { return }
        relatedPeople = await loadRelatedItems(urls: peopleURLs, fetchMethod: repository.fetchPersonByURL)
    }

    func loadRelatedPlanets() async {
        guard let repository = planetsRepository else { return }
        relatedPlanets = await loadRelatedItems(urls: planetsURLs, fetchMethod: repository.fetchPlanetByURL)
    }

    func loadRelatedStarships() async {
        guard let repository = starshipsRepository else { return }
        relatedStarships = await loadRelatedItems(urls: starshipsURLs, fetchMethod: repository.fetchStarshipByURL)
    }

    func loadRelatedVehicles() async {
        guard let repository = vehiclesRepository else { return }
        relatedVehicles = await loadRelatedItems(urls: vehiclesURLs, fetchMethod: repository.fetchVehicleByURL)
    }

    func loadRelatedSpecies() async {
        guard let repository = speciesRepository else { return }
        relatedSpecies = await loadRelatedItems(urls: speciesURLs, fetchMethod: repository.fetchSpeciesByURL)
    }

    func loadRelatedFilms() async {
        guard let repository = filmsRepository else { return }
        relatedFilms = await loadRelatedItems(urls: filmsURLs, fetchMethod: repository.fetchFilmByURL)
    }

    /// Generic function to load related items from URLs and save original order
    func loadRelatedItems<T>(urls: [String], fetchMethod: @escaping (String) async throws -> T) async -> [T] {
        guard !urls.isEmpty else { return [] }

        do {
            try Task.checkCancellation()
        } catch {
            print("Task cancelled before starting to load related items")
            return []
        }

        return await withTaskGroup(of: (index: Int, item: T?).self) { group in
            // Add a child task for each URL with its index
            for (index, url) in urls.enumerated() {
                group.addTask {
                    do {
                        try Task.checkCancellation()
                        return (index, try await fetchMethod(url))
                    } catch is CancellationError {
                        print("Subtask cancelled for URL at index \(index)")
                        return (index, nil)
                    } catch {
                        print("Error loading item from URL \(url): \(error.localizedDescription)")
                        return (index, nil)
                    }
                }
            }

            var orderedResults: [T?] = .init(repeating: nil, count: urls.count)

            // Collect all results
            for await result in group {
                if Task.isCancelled {
                    print("Task cancelled during result processing")
                    break
                }

                orderedResults[result.index] = result.item
            }

            if Task.isCancelled {
                print("Task cancelled before returning results")
                return orderedResults.compactMap { $0 }
            }

            return orderedResults.compactMap { $0 }
        }
    }
}
