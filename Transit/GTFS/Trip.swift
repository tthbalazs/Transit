import CSVInit
import Foundation

@CSVFragmentInitialized
struct TripRecord {
    let routeId: String
    let serviceId: String
    let tripId: String
    let tripHeadsign: String?
    let tripShortName: String?
    let directionId: String?
    let blockId: String?
    let shapeId: String?
    let wheelchairAccessible: String?
    let bikesAllowed: String?
}
