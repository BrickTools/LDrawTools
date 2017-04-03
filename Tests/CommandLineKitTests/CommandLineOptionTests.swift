import XCTest
@testable import CommandLineKit

class CommandLineOptionTests: XCTestCase {
    func testCommandLineOption() {
        let option = CommandLineOption(name: "--option", description: "Awesome description", numberOfParameters: 42)

        XCTAssertEqual(option.name, "--option")
        XCTAssertEqual(option.description, "Awesome description")
        XCTAssertEqual(option.numberOfParameters, 42)
    }
}
