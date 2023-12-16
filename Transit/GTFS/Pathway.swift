import CSVInit
import Foundation

@CSVFragmentInitialized
struct PathwayRecord {
    let pathwayId: String
    let fromStopId: String
    let toStopId: String
    let pathwayMode: String
    let isBidirectional: String
    let length: String?
    let traversalTime: String?
    let stairCount: String?
    let maxSlope: String?
    let minWidth: String?
    let signpostedAs: String?
    let reversedSignpostedAs: String?
}
