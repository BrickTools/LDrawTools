import Foundation
import LDrawKit

// MARK: Sort

func byDescription(color: Color, anotherColor: Color) -> Bool {
    return color.name < anotherColor.name
}

func byCode(color: Color, anotherColor: Color) -> Bool {
    return color.code < anotherColor.code
}

// MARK: Filter

func descriptionContains(term: String) -> ColorFilter {
    return { color in color.name.lowercased().contains(term.lowercased()) }
}

// MARK: Reduce

func toList(original: String, color: Color) -> String {
    return original
        + String(color.code).padding(toLength: 10, withPad: " ", startingAt: 0)
        + color.name
        + "\n"
}

func applyFilter(original: [Color], filter: ColorFilter) -> [Color] {
    return original.filter(filter)
}

func applySort(original: [Color], sort: ColorSort) -> [Color] {
    return original.sorted(by: sort)
}
