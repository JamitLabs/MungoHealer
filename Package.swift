// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "MungoHealer",
    products: [
        .library(name: "MungoHealer", targets: ["MungoHealer"])
    ],
    targets: [
        .target(
            name: "MungoHealer",
            path: "Frameworks/MungoHealer",
            exclude: ["Frameworks/SupportingFiles"]
        ),
        .testTarget(
            name: "MungoHealerTests",
            dependencies: ["MungoHealer"],
            exclude: ["Tests/SupportingFiles"]
        )
    ]
)
