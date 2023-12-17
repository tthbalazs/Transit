import CSVInit
import Foundation

@CSVFragmentInitialized
struct TimeframeRecord {
    let timeframeGroupId: String
    let startTime: String?
    let endTime: String?
    let serviceId: String
}
