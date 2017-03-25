import Foundation

/// MARK: Filter

func hasDatExtension(pathString: String) -> Bool {
    return pathString.hasSuffix(".dat")
}
