import Foundation

extension Collection {
    public subscript(safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
