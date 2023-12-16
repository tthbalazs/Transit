import CSVInit
import Foundation

@CSVFragmentInitialized
struct FrequencyRecord {
    let tripId: String
    let startTime: String
    let endTime: String
    let headwaySecs: String
    let exactTimes: String?
}
