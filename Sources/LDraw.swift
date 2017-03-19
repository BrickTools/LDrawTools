import Foundation

struct LDraw {
    private func allPaths(from directory: String) -> [String] {
        var files: [String] = []

        let pathURL = URL(fileURLWithPath: directory, isDirectory: true)
        let fileManager = FileManager.default
        let directoryEnumerator = try? fileManager.contentsOfDirectory(at: pathURL, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)

        if let enumarator = directoryEnumerator {
            for fileURL in enumarator {
                files.append(fileURL.path)
            }
        }

        return files
    }

    private func partFrom(file path: String) -> Part? {
        if let data = try? String(contentsOfFile: path, encoding: .utf8) {
            let lines = data.components(separatedBy: "\r\n")

            guard
                let firstLine = lines[safe: 0],
                let titleLocation = firstLine.range(of: "0 "),
                let secondLine = lines[safe: 1]
                else {
                    return nil
            }

            let title = firstLine.replacingCharacters(in: titleLocation, with: "").trimmingCharacters(in: .whitespaces)
            let partCode = secondLine.replacingOccurrences(of: "0 Name: ", with: "")

            return Part(fileName: partCode, description: title)
        }

        return nil
    }

    func allParts() -> [Part] {
        var parts: [Part] = []

        for file in allPaths(from: "parts").filter(hasDatExtension) {
            if let part = partFrom(file: file) {
                parts.append(part)
            }
        }
        
        return parts
    }
}
