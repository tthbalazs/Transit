import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(CSVInitMacros)
import CSVInitMacros

let testMacros: [String: Macro.Type] = [
    "CSVFragmentInitialized": CSVFragmentInitialized.self
]
#endif

final class CSVInitTests: XCTestCase {
    func testMacro() throws {
#if canImport(CSVInitMacros)
        assertMacroExpansion(
            """
            @CSVFragmentInitialized
            struct Agency {
                let agencyName: String
                let agencyTimezone: String?
            }
            """,
            expandedSource: """
            struct Agency {
                let agencyName: String
                let agencyTimezone: String?

                init(fragment: CSVFragment) {
                    agencyName = fragment["agency_name"]
                    agencyTimezone = fragment["agency_timezone"]
                }
            }
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
