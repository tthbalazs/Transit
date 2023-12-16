import CSVInit
import Foundation

@CSVFragmentInitialized
struct FareRuleRecord {
    let fareId: String
    let routeId: String?
    let originId: String?
    let destinationId: String?
    let containsId: String?
}
