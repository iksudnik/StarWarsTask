//
//  RepositoryError.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

enum RepositoryError: Error {
    case noInternetNoCache
    case apiError(String)
    case parseError(String)
    case cacheError(String)
    
    var localizedDescription: String {
        switch self {
        case .noInternetNoCache:
            return Localized.UI.noInternetNoCache
        case .apiError(let message):
            return "API Error: \(message)"
        case .parseError(let message):
            return "Parse Error: \(message)"
        case .cacheError(let message):
            return "Cache Error: \(message)"
        }
    }
}
