import Foundation

struct DatasetSource: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let url: URL
}

struct DatasetArchive: Identifiable {
    let id: UUID = UUID()
    let sourceId: UUID
    let name: String

    var archiveUrl: URL?
    var dataset: Dataset?
}

struct Dataset {
    var agency: URL
    var stops: URL
    var routes: URL
    var trips: URL
    var stopTimes: URL
    var calendar: URL?
    var calendarDates: URL?
    var fareAttributes: URL?
    var fareRules: URL?
    var timeframes: URL?
    var fareMedia: URL?
    var fareProducts: URL?
    var fareLegRules: URL?
    var fareTransferRules: URL?
    var areas: URL?
    var stopAreas: URL?
    var networks: URL?
    var routeNetworks: URL?
    var shapes: URL?
    var frequencies: URL?
    var transfers: URL?
    var pathways: URL?
    var levels: URL?
    var translations: URL?
    var feedInfo: URL?
    var attributions: URL?
}
