import Foundation

typealias URLFilter = (URL) -> Bool

func hasExtension(_ string: String) -> URLFilter {
    return { pathURL in pathURL.pathExtension == string }
}
