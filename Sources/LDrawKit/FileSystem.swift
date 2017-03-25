import Foundation

struct FileSystem {
    func contentFrom(fileWithPath path: String) -> String? {
        return try? String(contentsOfFile: path)
    }

    func allFiles(fromPath path: String) -> [String] {
        var files: [String] = []

        let pathURL = URL(fileURLWithPath: path, isDirectory: true)
        let fileManager = FileManager.default
        let directoryEnumerator = try? fileManager.contentsOfDirectory(at: pathURL, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)

        if let enumarator = directoryEnumerator {
            for fileURL in enumarator {
                files.append(fileURL.path)
            }
        }

        return files
    }
}
