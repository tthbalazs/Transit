import SwiftUI
import ZIPFoundation

@Observable final class DatasetSourcesViewModel {
    var sources: [DatasetSource]

    init(
        sources: [DatasetSource]
    ) {
        self.sources = sources
    }
}

struct DatasetSourcesView: View {
    var viewModel: DatasetSourcesViewModel

    var body: some View {
        List(viewModel.sources) { source in
            NavigationLink {
                DatasetArchivesView(
                    viewModel: DatasetArchivesViewModel(
                        source: source
                    )
                )
            } label: {
                Text(source.name)
            }
        }
        .navigationTitle("Data sources")
    }
}

#Preview {
    NavigationView {
        DatasetSourcesView(
            viewModel: DatasetSourcesViewModel(
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
