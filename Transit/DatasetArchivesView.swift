import SwiftUI
import ZIPFoundation

@Observable final class DatasetArchivesViewModel {
    var source: DatasetSource
    var archives: [DatasetArchive]
    var title: String {
        source.name + " archives"
    }
    var isDownloading: Bool = false

    init(
        source: DatasetSource,
        archives: [DatasetArchive] = [],
        datasetDownloader: DatasetDownloader = DatasetDownloader()
    ) {
        self.source = source
        self.archives = archives
        self.datasetDownloader = datasetDownloader
    }

    func downloadLatestArchive() async {
        do {
            isDownloading = true
            let fileManager = FileManager.default
            let datasetArchive = try await datasetDownloader.downloadDataset(from: source)
            archives.append(datasetArchive)

            let archiveUrl = datasetArchive.archiveUrl
            let unzipLocation = archiveUrl
                .deletingLastPathComponent()
                .appending(path: source.id.uuidString)
            try fileManager.unzipItem(at: archiveUrl, to: unzipLocation)
            isDownloading = false
        } catch {
            // TODO: Display errors or otherwise handle them
            print(error.localizedDescription)
        }
    }

    private let datasetDownloader: DatasetDownloader
}

struct DatasetArchivesView: View {
    var viewModel: DatasetArchivesViewModel

    var body: some View {
        VStack {
            List(viewModel.archives) { archive in
                NavigationLink(destination: {
                    EmptyView()
                }, label: {
                    VStack(alignment: .leading) {
                        Text(archive.archiveUrl.lastPathComponent)
                            .bold()
                        Text(archive.downloadedAt, style: .date)
                    }
                })
            }
        }
        .toolbar(content: {
            ToolbarItem {
                if viewModel.isDownloading {
                    ProgressView()
                } else {
                    Button(action: {
                        Task {
                            await viewModel.downloadLatestArchive()
                        }
                    }, label: {
                        Label("Download latest", systemImage: "square.and.arrow.down.fill")
                    })
                }
            }
        })
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    NavigationView {
        DatasetArchivesView(
            viewModel: DatasetArchivesViewModel(
                source: DatasetSource(
                    name: "Test",
                    url: URL(string: "http://www.example.com")!
                ),
                archives: [
                    DatasetArchive(
                        sourceId: UUID(),
                        name: "Latest zip",
                        archiveUrl: URL(string: "/Users/swanson/Library/Developer/CoreSimulator/Devices/30963487-1F00-44DE-9382-0AF548DD4F6F/data/Containers/Data/Application/FBDE6FF2-18F1-4E20-B95E-A343760526B0/Documents/20231216_20231222.zip")!,
                        downloadedAt: .now.addingTimeInterval(-2341)
                    )
                ]
            )
        )
    }
}
