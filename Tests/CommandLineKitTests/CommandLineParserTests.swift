import XCTest
@testable import CommandLineKit

class CommandLineParserTests: XCTestCase {
    var parser: CommandLineParser?

    override func setUp() {
        super.setUp()

        let options = [
            CommandLineOption(name: "-a", description: "Option a"),
            CommandLineOption(name: "-b", description: "Option b", numberOfParameters: 1),
            CommandLineOption(name: "-c", description: "Option c", numberOfParameters: 2),
            CommandLineOption(name: "--defg", description: "Option defg", numberOfParameters: 3)
        ]

        parser = CommandLineParser(options: options)
    }

    func testRunWithValidArguments() {
        var results: [String : [String]] = [:]
        let arguments = "-a -b one -c two three --defg four five six"

        parser?.run(arguments: arguments.components(separatedBy: .whitespaces)) { option in
            switch option {
            case .success(let commandName, let parameters):
                results[commandName] = parameters
            default:
                break
            }
        }

        XCTAssertEqual(results["-a"]!, [])
        XCTAssertEqual(results["-b"]!, ["one"])
        XCTAssertEqual(results["-c"]!, ["two", "three"])
        XCTAssertEqual(results["--defg"]!, ["four", "five", "six"])
    }

    func testRunWithToFewParameters() {
        var passedCommandName: String?
        let arguments = "--defg one"

        parser?.run(arguments: arguments.components(separatedBy: .whitespaces)) { option in
            switch option {
            case .failure(let commandName):
                passedCommandName = commandName
            default:
                break
            }
        }

        XCTAssertEqual(passedCommandName, "--defg")
    }

    func testRunWithTooManyParameters() {
        var passedCommandName: String?
        let arguments = "--defg one two three four"

        parser?.run(arguments: arguments.components(separatedBy: .whitespaces)) { option in
            switch option {
            case .failure(let commandName):
                passedCommandName = commandName
            default:
                break
            }
        }

        XCTAssertEqual(passedCommandName, "--defg")
    }

    func testHelp() {
        let expectedHelp = "OPTIONS:\n"
            + "-a      Option a\n"
            + "-b      Option b\n"
            + "-c      Option c\n"
            + "--defg  Option defg"

        XCTAssertEqual(parser?.helpOptions(), expectedHelp)
    }
}
