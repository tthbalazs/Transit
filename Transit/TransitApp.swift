import SwiftUI

@main
struct TransitApp: App {
    var body: some Scene {
        WindowGroup {
            DatasetSourceView(
                viewModel: DatasetSourceViewModel(
                    sources: [
                        DatasetSource(
                            name: "ZTM",
                            url: URL(string: "https://www.ztm.poznan.pl/pl/dla-deweloperow/getGTFSFile")!
                        )
                    ]
                )
            )
        }
    }
}
