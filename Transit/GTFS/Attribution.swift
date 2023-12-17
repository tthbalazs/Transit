import CSVInit
import Foundation

@CSVFragmentInitialized
struct AttributionRecord {
    let attributionId: String?
    let agencyId: String?
    let routeId: String?
    let tripId: String?
    let organizationName: String
    let isProducer: String?
    let isOperator: String?
    let isAuthority: String?
    let attributionUrl: String?
    let attributionEmail: String?
    let attributionPhone: String?
}
