//
//  APIError.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

public enum APIError: Error {
	case invalidURL
	case invalidResponse
	case httpError(statusCode: Int)
	case decodingError(Error)

	var localizedDescription: String {
		switch self {
			case .invalidURL:
				return "Invalid URL provided"
			case .invalidResponse:
				return "Invalid response from server"
			case .httpError(let statusCode):
				return "HTTP status code error: \(statusCode)"
			case .decodingError(let error):
				return "Failed to decode data: \(error.localizedDescription)"
		}
	}
}
