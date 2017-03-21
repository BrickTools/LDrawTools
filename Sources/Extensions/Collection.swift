import Foundation

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
