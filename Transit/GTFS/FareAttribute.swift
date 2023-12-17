import CSVInit
import Foundation

@CSVFragmentInitialized
struct FareAttributeRecord {
    let fareId: String
    let price: String
    let currencyType: String
    let paymentMethod: String
    let transfers: String
    let agencyId: String?
    let transferDuration: String?
}
