import Foundation
import Extensions

public struct LDraw {
    let ldrawURL: URL
    let fileSystem = FileSystem()

    public init(path: String = "") {
        self.ldrawURL = URL(fileURLWithPath: path, isDirectory: true)
    }

    public func allParts() -> [Part] {
        guard let directoryURL = URL(string: "parts", relativeTo: ldrawURL) else { return [] }

        return fileSystem.allFiles(at: directoryURL)
            .filter(hasExtension("dat"))
            .flatMap { fileSystem.contentOfFile(at: $0).flatMap(Part.init) }
    }

    public func allColors() -> [Color] {
        guard let fileURL = URL(string: "LDConfig.ldr", relativeTo: ldrawURL) else { return [] }

        return fileSystem.contentOfFile(at: fileURL)
            .flatMap { $0.components(separatedBy: .newlines) }?
            .flatMap(Color.init) ?? []
    }
}
