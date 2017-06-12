import Foundation

public struct Color: Codable {
    public let name: String
    public let code: Int
    public let value: String
    public let edge: String
    public let alpha: Int?
    public let luminance: Int?
}

extension Color {
    init?(string: String) {
        var nameString: String?
        var codeInt: Int?
        var valueString: String?
        var edgeString: String?
        var alphaInt: Int?
        var luminanceInt: Int?

        let elements = string.replacingOccurrences(of: "0 !COLOUR ", with: "").condensed().components(separatedBy: .whitespaces)

        for (index, element) in elements.enumerated() {
            switch (index, element) {
            case (0, _):
                nameString = element.replacingOccurrences(of: "_", with: " ")
            case (_, "CODE"):
                codeInt = Int(elements[index + 1])
            case (_, "VALUE"):
                valueString = elements[index + 1]
            case (_, "EDGE"):
                edgeString = elements[index + 1]
            case (_, "ALPHA"):
                alphaInt = Int(elements[index + 1])
            case (_, "LUMINANCE"):
                luminanceInt = Int(elements[index + 1])
            default:
                break
            }
        }

        guard
            let name = nameString,
            let code = codeInt,
            let value = valueString,
            let edge = edgeString
            else {
                return nil
        }

        self.name = name
        self.code = code
        self.value = value
        self.edge = edge
        self.alpha = alphaInt
        self.luminance = luminanceInt
    }
}
