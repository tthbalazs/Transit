import CSVInit
import Foundation

@CSVFragmentInitialized
struct ShapeRecord {
    let shapeId: String
    let shapePtLat: String
    let shapePtLon: String
    let shapePtSequence: String
    let shapeDistTraveled: String?
}
