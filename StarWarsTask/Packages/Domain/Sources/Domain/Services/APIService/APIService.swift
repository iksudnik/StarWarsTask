//
//  APIService.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

public protocol APIServiceProtocol {
	func fetch<T: Decodable>(endpoint: APIEndpoint, page: Int) async throws -> T
	func fetchByURL<T: Decodable>(url: String) async throws -> T
}

/// Simple implementation of api service
public final class APIService: APIServiceProtocol {
	private let session: URLSession

	public init(session: URLSession? = nil) {
		 if let session = session {
            self.session = session
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30.0
            self.session = URLSession(configuration: configuration)
        }
	}

	public func fetch<T: Decodable>(endpoint: APIEndpoint, page: Int) async throws -> T {
		var urlComponents = URLComponents(string: endpoint.urlString)
		urlComponents?.queryItems = [URLQueryItem(name: "page", value: "\(page)")]

		guard let url = urlComponents?.url else {
			throw APIError.invalidURL
		}

		return try await performRequest(with: url)
	}


	public func fetchByURL<T: Decodable>(url: String) async throws -> T {
		guard let url = URL(string: url) else {
			throw APIError.invalidURL
		}

		return try await performRequest(with: url)
	}

	// MARK: - Private 
	private func performRequest<T: Decodable>(with url: URL) async throws -> T {
		let (data, response) = try await session.data(from: url)

		guard let httpResponse = response as? HTTPURLResponse else {
			throw APIError.invalidResponse
		}

		guard 200...299 ~= httpResponse.statusCode else {
			throw APIError.httpError(statusCode: httpResponse.statusCode)
		}

		do {
			return try JSONDecoder().decode(T.self, from: data)
		} catch let decodingError {
			throw APIError.decodingError(decodingError)
		}
	}
}
