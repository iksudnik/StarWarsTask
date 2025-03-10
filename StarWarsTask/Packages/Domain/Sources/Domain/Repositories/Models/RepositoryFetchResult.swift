//
//  RepositoryFetchResult.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 09.03.2025.
//

import Foundation

public struct RepositoryFetchResult<T: Identifiable & Hashable> {
	public let items: [T]
	public let hasMore: Bool
	public let nextPage: Int?

	public init(items: [T], hasMore: Bool, nextPage: Int? = nil) {
		self.items = items
		self.hasMore = hasMore
		self.nextPage = nextPage
	}
}
