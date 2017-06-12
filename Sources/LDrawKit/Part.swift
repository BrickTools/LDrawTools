import Foundation
import Extensions

public struct Part: Codable {
    public let fileName: String
    public let description: String
}

extension Part {
    init?(fileContent: String) {
        let lines = fileContent.components(separatedBy: "\r\n")

        guard
            let firstLine = lines[safe: 0],
            let titleLocation = firstLine.range(of: "0 "),
            let secondLine = lines[safe: 1]
            else {
                return nil
        }

        description = firstLine.replacingCharacters(in: titleLocation, with: "").condensed()
        fileName = secondLine.replacingOccurrences(of: "0 Name: ", with: "")
    }
}
