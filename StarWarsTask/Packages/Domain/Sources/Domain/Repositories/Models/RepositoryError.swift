//
//  RepositoryError.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Core
import Foundation

public enum RepositoryError: Error {
    case apiError(String)
    case cacheError(String)
    case noInternetNoCache
    
    var localizedDescription: String {
		switch self {
			case .apiError(let message):
				return "API Error: \(message)"
			case .cacheError(let message):
				return "Cache Error: \(message)"
			case .noInternetNoCache:
				return Localized.UI.noInternetNoCache
		}
    }
}
