import Foundation
import LDrawKit

// MARK: Map

func toDictionary(color: Color) -> [String : Any?] {
    return [
        "name": color.name,
        "code": color.code,
        "value": color.value,
        "edge": color.edge,
        "alpha": color.alpha,
        "luminance": color.luminance
    ]
}

// MARK: Sort

func byDescription(color: Color, anotherColor: Color) -> Bool {
    return color.name < anotherColor.name
}

func byCode(color: Color, anotherColor: Color) -> Bool {
    return color.code < anotherColor.code
}

// MARK: Reduce

func toList(original: String, color: Color) -> String {
    return original
        + String(color.code).padding(toLength: 10, withPad: " ", startingAt: 0)
        + color.name
        + "\n"
}

func applySort(original: [Color], sort: ColorSort) -> [Color] {
    return original.sorted(by: sort)
}
