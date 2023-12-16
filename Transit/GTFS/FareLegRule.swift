import CSVInit
import Foundation

@CSVFragmentInitialized
struct FareLegRuleRecord {
    let legGroupId: String?
    let networkId: String?
    let fromAreaId: String?
    let toAreaId: String?
    let fromTimeframeGroupId: String?
    let toTimeframeGroupId: String?
    let fareProductId: String
}
