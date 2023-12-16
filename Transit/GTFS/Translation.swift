import CSVInit
import Foundation

@CSVFragmentInitialized
struct TranslationRecord {
    let tableName: String
    let fieldName: String
    let language: String
    let translation: String
    let recordId: String?
    let recordSubId: String?
    let fieldValue: String?
}
