import CSVInit
import Foundation

@CSVFragmentInitialized
struct FareProductRecord {
    let fareProductId: String
    let fareProductName: String?
    let fareMediaId: String?
    let amount: String
    let currency: String
}
