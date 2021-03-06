import Foundation
import LDrawKit

enum OutputType {
    case list, json

    func convert(_ colors: [Color]) -> String {
        switch self {
        case .list:
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
