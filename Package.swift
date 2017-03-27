import PackageDescription

let package = Package(
    name: "LDrawTools",
    targets: [
        Target(name: "Extensions"),
        Target(name: "SimpleCommandLineKit"),
        Target(name: "LDrawKit", dependencies: ["Extensions"]),
        Target(name: "LDMakeList", dependencies: ["LDrawKit", "SimpleCommandLineKit"]),
        Target(name: "LDColorList", dependencies: ["LDrawKit", "SimpleCommandLineKit"])
    ]
)
