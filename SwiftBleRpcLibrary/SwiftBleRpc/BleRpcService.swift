import Foundation

/// Ble abstract service that supports injection of BleWorker.
public class BleRpcService {
    // MARK: - Variables

    /// BleWorker with which service will interact.
    internal let bleWorker: BleServiceDriver

    // MARK: - Initializers

    /// Initialize with *BleWorker*.
    /// - parameter bleWorker: BleWorker with connected device.
    /// - returns: service with injected BleWorker.
    public init(_ bleWorker: BleServiceDriver) {
        self.bleWorker = bleWorker
    }

    /// Block default init.
    private init() {
        fatalError("Please use init(bleWorker:) instead.")
    }
}
