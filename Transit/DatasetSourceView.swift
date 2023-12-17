import SwiftUI

@Observable final class DatasetSourceViewModel {
    var sources: [DatasetSource]
    var archives: [DatasetArchive] = []

    init(
        sources: [DatasetSource],
        datasetDownloader: DatasetDownloader = DatasetDownloader()
    ) {
        self.sources = sources
        self.datasetDownloader = datasetDownloader
    }

    func download(source: DatasetSource) async {
        do {
            let datasetArchive = try await datasetDownloader.downloadDataset(from: source)
            archives.append(datasetArchive)
        } catch {
            // TODO: Display errors or otherwise handle them
            print(error.localizedDescription)
        }
    }

    private let datasetDownloader: DatasetDownloader
}

struct DatasetSourceView: View {
    var viewModel: DatasetSourceViewModel

    var body: some View {
        NavigationView {
            List(viewModel.sources, id: \.self) { source in
                VStack(alignment: .leading) {
                    Text(source.name)
                        .font(.title2)
                    Text(source.url.absoluteString)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
            .navigationTitle("Data sources")
        }
    }
}

#Preview {
    DatasetSourceView(
        viewModel: .init(
            sources: [
                DatasetSource(
                    name: "ZTM",
                    url: URL(string: "https://www.ztm.poznan.pl/pl/dla-deweloperow/getGTFSFile/?file=20231216_20231222.zip")!
                )
            ]
        )
    )
}
