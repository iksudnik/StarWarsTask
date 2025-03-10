//
//  StorageServiceProtocol.swift
//  StarWarsTask
//
//  Created by Ilja Sudnik on 08.03.2025.
//

import Foundation

public protocol StorageServiceProtocol {
    func save<T: Encodable>(_ object: T, forKey key: String) throws
    func load<T: Decodable>(forKey key: String) throws -> T
    func exists(forKey key: String) -> Bool
    func remove(forKey key: String)
}

/// Simple implementation of local storage using file system
public final class FileSystemStorageService: StorageServiceProtocol {
    private let fileManager = FileManager.default
    
    private var cacheDirectory: URL {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("SWCache")
    }
    
	public init() {
        createCacheDirIfNeeded()
    }
    
    private func createCacheDirIfNeeded() {
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectory, 
                                             withIntermediateDirectories: true, 
                                             attributes: nil)
            } catch {
                print("Can't create cache directory: \(error)")
            }
        }
    }

	public func save<T: Encodable>(_ data: T, forKey key: String) throws {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        let data = try JSONEncoder().encode(data)
        try data.write(to: fileURL)
    }

	public func load<T: Decodable>(forKey key: String) throws -> T {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(T.self, from: data)
    }

	public func exists(forKey key: String) -> Bool {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        return fileManager.fileExists(atPath: fileURL.path)
    }
    
	public func remove(forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        try? fileManager.removeItem(at: fileURL)
    }
} 
