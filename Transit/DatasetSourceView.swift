import SwiftUI
import ZIPFoundation

@Observable final class DatasetSourceViewModel {
    var sources: [DatasetSource]
    var archives: [UUID: [DatasetArchive]] = [:]

    init(
        sources: [DatasetSource],
        datasetDownloader: DatasetDownloader = DatasetDownloader()
    ) {
        self.sources = sources
        self.datasetDownloader = datasetDownloader
    }

    func download(source: DatasetSource) async {
        do {
            let fileManager = FileManager.default
            let datasetArchive = try await datasetDownloader.downloadDataset(from: source)
            if let previousArchives = archives[source.id] {
                archives[source.id] = previousArchives + [datasetArchive]
            } else {
                archives[source.id] = [datasetArchive]
            }

            let archiveUrl = datasetArchive.archiveUrl
            let unzipLocation = archiveUrl
                .deletingLastPathComponent()
                .appending(path: source.id.uuidString)
            try fileManager.unzipItem(at: archiveUrl, to: unzipLocation)
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
                Section(source.name) {
                    VStack {
                        HStack {
                            Text("Source")
                            Spacer()
                            Text(source.url.absoluteString)
                                .foregroundStyle(.blue)
                                .font(.caption)
                        }
                        Button(action: {
                            Task {
                                await viewModel.download(source: source)
                            }
                        }, label: {
                            Text("Download latest dataset")
                        })
                    }
                    if let archives = viewModel.archives[source.id] {
                        List(archives) { archive in
                            VStack {
                                Text(archive.name)
                                Text(archive.archiveUrl.absoluteString)
                            }
                        }
                    }
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
                    url: URL(string: "https://www.ztm.poznan.pl/pl/dla-deweloperow/getGTFSFile")!
                )
            ]
        )
    )
}
