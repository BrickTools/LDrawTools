import Foundation

func hasDatExtension(pathURL: URL) -> Bool {
    return pathURL.pathExtension == "dat"
}
