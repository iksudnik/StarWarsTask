//
//  RepositoryFetchResult.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Foundation

struct RepositoryFetchResult<T: Codable> {
	let items: [T]
	let hasMore: Bool
	let nextPage: Int?
}
