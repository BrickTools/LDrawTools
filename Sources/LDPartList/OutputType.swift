import Foundation
import LDrawKit

enum OutputType {
    case list, json

    func convert(_ parts: [Part]) -> String {
        switch self {
        case .list:
            return parts.reduce("", toList)

        case .json:
            let encoder = JSONEncoder()

            guard
                let data = try? encoder.encode(parts),
                let string = String(data: data, encoding: .utf8)
                else {
                    return ""
            }

            return string
        }
    }
}
