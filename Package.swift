import PackageDescription

let package = Package(
    name: "LDrawTools",
    targets: [
        Target(name: "Extensions"),
        Target(name: "CommandLineKit"),
        Target(name: "LDrawKit", dependencies: ["Extensions"]),
        Target(name: "LDMakeList", dependencies: ["LDrawKit", "CommandLineKit"]),
        Target(name: "LDColorList", dependencies: ["LDrawKit", "CommandLineKit"])
    ]
)
