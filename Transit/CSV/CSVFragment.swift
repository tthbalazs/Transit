import Foundation

// This might not be the best way to initialize our objects from CSV, but it's a good first draft.
// Ideally we would have a `Decoder` implementation and leverage `Decodable`.
struct CSVFragment {
    init(
        headerMapping: [String : Int],
        line: String,
        separator: String = ","
    ) {
        self.headerMapping = headerMapping
        self.components = line.components(separatedBy: separator)
    }

    subscript(key: String) -> String {
        guard let mappedIndex = headerMapping[key] else {
            assertionFailure("Required key doesn't exist in the header")
            return ""
        }
        guard components.indices.contains(mappedIndex) else {
            assertionFailure("Line does not contain required data")
            return ""
        }
        return components[mappedIndex]
    }

    subscript(key: String) -> String? {
        guard let mappedIndex = headerMapping[key] else { return nil }
        guard components.indices.contains(mappedIndex) else { return nil }
        return components[mappedIndex]
    }

    private let headerMapping: [String: Int]
    private let components: [String]
}

protocol InitializableByCSVFragment {
    // Maybe it would be better to make this a failable init, and not allow subscripting non-optionals?
    init(csvFragment: CSVFragment)
}
