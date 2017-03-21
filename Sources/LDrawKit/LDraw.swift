import Foundation
import Extensions

public struct LDraw {
    let fileSystem = FileSystem()

    public init() { }

    public func allParts() -> [Part] {
        var parts: [Part] = []

        for file in fileSystem.allFiles(fromPath: "parts").filter(hasDatExtension) {
            if let content = fileSystem.contentFrom(fileWithPath: file) {
                if let part = try? Part(fileContent: content) {
                    parts.append(part)
                }
            }
        }

        return parts
    }

    public func allColors() -> [Color] {
        var colors: [Color] = []

        if let data = fileSystem.contentFrom(fileWithPath: "LDConfig.ldr") {
            let lines = data.components(separatedBy: .newlines)

            for line in lines {
                if let color = try? Color(string: line) {
                    colors.append(color)
                }
            }
        }
        
        return colors
    }
}
