import CSVInit
import Foundation

@CSVFragmentInitialized
struct FeedInfoRecord {
    let feedPublisherName: String
    let feedPublisherUrl: String
    let feedLang: String
    let defaultLang: String?
    let feedStartDate: String?
    let feedEndDate: String?
    let feedVersion: String?
    let feedContactEmail: String?
    let feedContactUrl: String?
}
