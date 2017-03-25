import PackageDescription

let package = Package(
    name: "LDrawTools",
    targets: [
        Target(name: "Extensions"),
        Target(name: "LDrawKit", dependencies: ["Extensions"]),
        Target(name: "LDMakeList", dependencies: ["LDrawKit"]),
        Target(name: "LDColorList", dependencies: ["LDrawKit"])
    ]
)
