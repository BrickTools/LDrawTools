import Foundation
import LDrawKit

enum OutputType: String {
    case list, json, plist

    func convert(_ colors: [Color]) -> String {
        switch self {
        case .list:
            return colors.reduce("", toList)

        case .json:
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            guard
                let data = try? encoder.encode(colors),
                let string = String(data: data, encoding: .utf8)
                else {
                    return ""
            }

            return string

        case .plist:
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml

            guard
                let data = try? encoder.encode(colors),
                let string = String(data: data, encoding: .utf8)
                else {
                    return ""
            }

            return string
        }
    }
}
