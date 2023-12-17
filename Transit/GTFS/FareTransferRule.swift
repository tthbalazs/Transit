import CSVInit
import Foundation

@CSVFragmentInitialized
struct FareTransferRuleRecord {
    let fromLegGroupId: String?
    let toLegGroupId: String?
    let transferCount: String?
    let durationLimit: String?
    let durationLimitType: String?
    let fareTransferType: String
    let fareProductId: String?
}
