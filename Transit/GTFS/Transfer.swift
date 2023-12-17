import CSVInit
import Foundation

@CSVFragmentInitialized
struct TransferRecord {
    let fromStopId: String?
    let toStopId: String?
    let fromRouteId: String?
    let toRouteId: String?
    let fromTripId: String?
    let toTripId: String?
    let transferType: String
    let minTransferTime: String?
}
