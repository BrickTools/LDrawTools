import Foundation
import LDrawKit

enum OutputType {
    case text, json

    func toString(colors: [Color]) -> String {
        switch self {
        case .text:
            return colors.reduce("", toList)

        case .json:
            let array = colors.map(toDictionary)

            guard
                let data = try? JSONSerialization.data(withJSONObject: array, options: .prettyPrinted),
                let string = String(data: data, encoding: .utf8)
                else {
                    return ""
            }

            return string
        }
    }
}
