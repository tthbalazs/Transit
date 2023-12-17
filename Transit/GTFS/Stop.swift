import CSVInit
import Foundation

@CSVFragmentInitialized
struct StopRecord {
    let stopId: String
    let stopCode: String?
    let stopName: String?
    let ttsStopName: String?
    let stopDesc: String?
    let stopLat: String?
    let stopLon: String?
    let zoneId: String?
    let stopUrl: String?
    let locationType: String?
    let parentStation: String?
    let stopTimezone: String?
    let wheelchairBoarding: String?
    let levelId: String?
    let platformCode: String?
}
