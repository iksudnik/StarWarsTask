import Foundation
import Network

/// Protocol that defines network connectivity monitoring capabilities
protocol ConnectivityServiceProtocol {
	/// Indicates whether device is connected to the internet
	var isConnected: Bool { get }

	/// Provides an async stream of connectivity status updates
	var connectivityUpdates: AsyncStream<Bool> { get }
}

/// Simple implementation of connectivity service
final class ConnectivityService: ConnectivityServiceProtocol {
	private let monitor = NWPathMonitor()
	private let queue = DispatchQueue(label: "ConnectivityService")

	private(set) var isConnected = false

	private var continuation: AsyncStream<Bool>.Continuation?

	lazy var connectivityUpdates: AsyncStream<Bool> = {
		AsyncStream { continuation in
			self.continuation = continuation
			// Send the current status immediately upon subscription
			continuation.yield(self.isConnected)

			continuation.onTermination = { [weak self] _ in
				self?.continuation = nil
			}
		}
	}()

	init() {
		startMonitoring()
	}

	deinit {
		stopMonitoring()
		continuation?.finish()
	}

	/// Starts monitoring network connectivity
	private func startMonitoring() {
		monitor.pathUpdateHandler = { [weak self] path in
			guard let self = self else { return }
			let newStatus = path.status == .satisfied

			if self.isConnected != newStatus {
				self.isConnected = newStatus
				// Emit to the AsyncStream
				self.continuation?.yield(newStatus)
			}
		}
		monitor.start(queue: queue)
	}

	/// Stops monitoring network connectivity
	private func stopMonitoring() {
		monitor.cancel()
	}
}
