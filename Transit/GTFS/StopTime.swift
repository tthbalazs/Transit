import CSVInit
import Foundation

@CSVFragmentInitialized
struct StopTimeRecord {
    let tripId: String
    let arrivalTime: String?
    let departureTime: String?
    let stopId: String
    let stopSequence: String
    let stopHeadsign: String?
    let pickupType: String?
    let dropOffType: String?
    let continuousPickup: String?
    let continuousDropOff: String?
    let shapeDistTraveled: String?
    let timepoint: String?
}
