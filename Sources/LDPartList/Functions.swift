import Foundation
import LDrawKit

// MARK: Map

func toDictionary(part: Part) -> [String : String] {
    return ["fileName": part.fileName, "description": part.description]
}

// MARK: Filter

func hasNotMoved(part: Part) -> Bool {
    return !part.description.lowercased().contains("moved to")
}

func noPrefix(string: String) -> PartFilter {
    return { part in !part.description.hasPrefix(string) }
}

func descriptionContains(string: String) -> PartFilter {
    return { part in part.description.lowercased().contains(string.lowercased()) }
}

// MARK: Sort

func byDescription(part: Part, anotherPart: Part) -> Bool {
    return part.description < anotherPart.description
}

func byFileName(part: Part, anotherPart: Part) -> Bool {
    return part.fileName < anotherPart.fileName
}

// MARK: Reduce

func toList(original: String, part: Part) -> String {
    return original
        + part.fileName.padding(toLength: 27, withPad: " ", startingAt: 0)
        + part.description
        + "\n"
}

func applyFilter(original: [Part], filter: PartFilter) -> [Part] {
    return original.filter(filter)
}

func applySort(original: [Part], sort: PartSort) -> [Part] {
    return original.sorted(by: sort)
}
