import Foundation
import LDrawKit

enum OutputType {
    case list, json

    func convert(_ colors: [Color]) -> String {
        switch self {
        case .list:
            return colors.reduce("", toList)

        case .json:
            let encoder = JSONEncoder()

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
