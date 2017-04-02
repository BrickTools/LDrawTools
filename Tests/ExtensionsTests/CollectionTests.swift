import XCTest
@testable import Extensions

class CollectionTests: XCTestCase {
    let words = ["Torschlusspanik", "Schnapsidee"]

    func testSafeAccessToExistingIndex() {
        let description = words[safe: 0]
        XCTAssertEqual(description, "Torschlusspanik")
    }

    func testSafeAccessToMissingIndex() {
        let description = words[safe: 3]
        XCTAssertNil(description)
    }
}
