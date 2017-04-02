import XCTest
@testable import Extensions

class StringTests: XCTestCase {
    func testCondensedWithLeadingSpaces() {
        let string = "    this is a string"
        let expectedString = "this is a string"

        XCTAssertEqual(string.condensed(), expectedString)
    }

    func testCondensedWithTrailingSpaces() {
        let string = "this is a string    "
        let expectedString = "this is a string"

        XCTAssertEqual(string.condensed(), expectedString)
    }

    func testCondensedWithSeveralSpacesBetweenWords() {
        let string = "this  is   a    string"
        let expectedString = "this is a string"

        XCTAssertEqual(string.condensed(), expectedString)
    }
}
