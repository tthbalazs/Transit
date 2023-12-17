import Foundation

final class DatasetDownloader: NSObject, FileManagerDelegate {
    enum DatasetDownloaderError: Error {
        /// Failed to generate the local file URL for the downloaded dataset archive
        case missingArchiveUrl
    }

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        super.init()

        fileManager.delegate = self
    }

    func downloadDataset(from source: DatasetSource) async throws -> DatasetArchive {
        let request = URLRequest(url: source.url)
        let (tempFile, response) = try await URLSession(configuration: .default).download(for: request)
        let fileName = response.suggestedFilename ?? "UnknownDataset.zip"

        guard let archiveUrl = fileManager
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appending(path: fileName)
        else {
            throw DatasetDownloaderError.missingArchiveUrl
        }

        try fileManager.moveItem(at: tempFile, to: archiveUrl)

        let dataset = DatasetArchive(
            sourceId: source.id,
            name: fileName,
            archiveUrl: archiveUrl,
            downloadedAt: .now
        )
        return dataset
    }

    // MARK: - FileManagerDelegate methods

    func fileManager(
        _ fileManager: FileManager,
        shouldProceedAfterError error: Error,
        movingItemAt srcURL: URL,
        to dstURL: URL
    ) -> Bool {
        // Continue if the file already exists
        // In the future, it would be okay to not even download the file again.
        return (error as NSError).code == CocoaError.fileWriteFileExists.rawValue
    }

    private let fileManager: FileManager
}
