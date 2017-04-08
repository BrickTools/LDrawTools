import Foundation
import Extensions

public struct LDraw {
    let ldrawURL: URL
    let fileSystem = FileSystem()

    public init(path: String = "") {
        self.ldrawURL = URL(fileURLWithPath: path, isDirectory: true)
    }

    public func allParts() -> [Part] {
        var parts: [Part] = []

        guard let directoryURL = URL(string: "parts", relativeTo: ldrawURL) else {
            return parts
        }

        for file in fileSystem.allFiles(at: directoryURL).filter(hasExtension("dat")) {
            if let content = fileSystem.contentOfFile(at: file) {
                if let part = try? Part(fileContent: content) {
                    parts.append(part)
                }
            }
        }

        return parts
    }

    public func allColors() -> [Color] {
        var colors: [Color] = []

        guard
            let fileURL = URL(string: "LDConfig.ldr", relativeTo: ldrawURL),
            let data = fileSystem.contentOfFile(at: fileURL)
            else {
                return colors
        }

        for line in data.components(separatedBy: .newlines) {
            if let color = try? Color(string: line) {
                colors.append(color)
            }
        }

        return colors
    }
}
