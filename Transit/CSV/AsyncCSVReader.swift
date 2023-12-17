import Combine
import Foundation

final class AsyncCSVReader {
    init(
        file: URL,
        lineSeparator: String = "\n",
        encoding: String.Encoding = .utf8
    ) {
        self.file = file
        self.lineSeparator = lineSeparator.data(using: .utf8) ?? Data(repeating: 10, count: 1) // \n as Data
        self.encoding = encoding
    }

    func readLines() -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            do {
                let handle = try FileHandle(forReadingFrom: file)

                var isEOF = false
                var buffer = Data(capacity: chunkSize)

                var remainingBufferRange: Range<Data.Index> = 0..<buffer.endIndex
                var eolRange: Range<Data.Index>? = nil

                while !isEOF {
                    eolRange = buffer.range(of: lineSeparator, in: remainingBufferRange)

                    while eolRange == nil {
                        // I guess chunk size and buffer size could be different in the future?
                        guard let newData = try handle.read(upToCount: chunkSize - remainingBufferRange.count) else {
                            isEOF = true
                            try handle.close()

                            // Maybe checking the remaining buffer range is enough?
                            if !buffer.isEmpty && !remainingBufferRange.isEmpty {
                                // Process the last line if there is still remaining data in the buffer
                                let lineData = buffer.subdata(in: remainingBufferRange)
                                if let line = String(data: lineData, encoding: encoding), !line.isEmpty {
                                    continuation.yield(line)
                                }
                            }
                            continuation.finish()
                            return
                        }

                        if remainingBufferRange.isEmpty {
                            buffer = newData
                        } else {
                            let remainingData = buffer.subdata(in: remainingBufferRange)
                            buffer = remainingData + newData
                        }

                        remainingBufferRange = 0..<buffer.endIndex
                        eolRange = buffer.range(of: lineSeparator, in: remainingBufferRange)
                    }

                    guard let eolRange else { continue }

                    let lineData = buffer.subdata(in: remainingBufferRange.lowerBound..<eolRange.lowerBound)
                    if let line = String(data: lineData, encoding: encoding) {
                        continuation.yield(line)
                    }

                    buffer.resetBytes(in: 0..<eolRange.upperBound)
                    remainingBufferRange = eolRange.upperBound..<buffer.endIndex
                }
            } catch {
                continuation.finish(throwing: error)
            }
        }
    }
    
    // MARK: - Private

    private let file: URL
    private let lineSeparator: Data
    private let encoding: String.Encoding

    private let chunkSize = 65535 // TODO: If a line is longer than `chunkSize`, we wouldn't read anything.
}
