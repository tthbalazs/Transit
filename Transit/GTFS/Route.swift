import CSVInit
import Foundation

@CSVFragmentInitialized
struct RouteRecord {
    let routeId: String
    let agencyId: String?
    let routeShortName: String?
    let routeLongName: String?
    let routeDesc: String?
    let routeType: String
    let routeUrl: String?
    let routeColor: String?
    let routeTextColor: String?
    let routeSortOrder: String?
    let continuousPickup: String?
    let continuousDropOff: String?
    let networkId: String?
}
