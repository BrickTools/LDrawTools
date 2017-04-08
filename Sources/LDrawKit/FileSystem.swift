import Foundation

struct FileSystem {
    func contentOfFile(at url: URL) -> String? {
        return try? String(contentsOf: url)
    }

    func allFiles(at directoryURL: URL) -> [URL] {
        let fileManager = FileManager.default
        let files = try? fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)

        return files ?? []
    }
}
