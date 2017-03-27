import Foundation
import LDrawKit

enum OutputType {
    case list, json

    func toString(parts: [Part]) -> String {
        switch self {
        case .list:
            return parts.reduce("", toList)

        case .json:
            let array = parts.map(toDictionary)

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
