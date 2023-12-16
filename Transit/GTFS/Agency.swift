import Foundation
import CSVInit

@CSVFragmentInitialized
struct Agency: Hashable {
    let agencyId: String?
    let agencyName: String
    let agencyUrl: String
    let agencyTimezone: String
    let agencyLang: String?
    let agencyPhone: String?
    let agencyFareUrl: String?
    let agencyEmail: String?
}
