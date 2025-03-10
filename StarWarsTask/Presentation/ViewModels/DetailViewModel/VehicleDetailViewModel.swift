//
//  VehicleDetailViewModel.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Core
import Domain
import SwiftUI

@MainActor
final class VehicleDetailViewModel: BaseDetailViewModel {
    private let vehicle: Vehicle
    
    init(
        vehicle: Vehicle,
        peopleRepository: PeopleRepositoryProtocol,
        filmsRepository: FilmsRepositoryProtocol
    ) {
        self.vehicle = vehicle
        super.init()
        
        self.peopleRepository = peopleRepository
        self.filmsRepository = filmsRepository
        
        self.peopleURLs = vehicle.pilots
        self.filmsURLs = vehicle.films
        
        if !vehicle.pilots.isEmpty { self.supportedRelatedTypes.append(.person) }
        if !vehicle.films.isEmpty { self.supportedRelatedTypes.append(.film) }
    }
}

// MARK: - Properties
extension VehicleDetailViewModel {
    var name: String { vehicle.name }
    var model: String { vehicle.model }
    var manufacturer: String { vehicle.manufacturer }
    var vehicleClass: String { vehicle.vehicleClass }
    var costInCredits: String { vehicle.costInCredits }
    var length: String { vehicle.length }
    var crew: String { vehicle.crew }
    var passengers: String { vehicle.passengers }
    var maxAtmospheringSpeed: String { vehicle.maxAtmospheringSpeed }
    var cargoCapacity: String { vehicle.cargoCapacity }
    var consumables: String { vehicle.consumables }

    var vehiclePilots: [Person] { relatedPeople }
    var vehicleFilms: [Film] { relatedFilms }
}
