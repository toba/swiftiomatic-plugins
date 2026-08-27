// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "swiftiomatic-plugins",
    platforms: [.macOS(.v26)],
    products: [
        .plugin(name: "SwiftiomaticBuildToolPlugin", targets: ["SwiftiomaticBuildToolPlugin"]),
        .plugin(name: "SwiftiomaticFormatPlugin", targets: ["SwiftiomaticFormatPlugin"]),
        .plugin(name: "SwiftiomaticLintPlugin", targets: ["SwiftiomaticLintPlugin"]),
    ],
    targets: [
        .binaryTarget(
            name: "SmBinary",
            url: "https://github.com/toba/swiftiomatic/releases/download/4.3.1/sm.artifactbundle.zip",
            checksum: "c18654979ef07ed52c8c5645db7a4ef242566bc75c7943c68826da0de091ccb6"
        ),
        .plugin(
            name: "SwiftiomaticBuildToolPlugin",
            capability: .buildTool(),
            dependencies: [.target(name: "SmBinary")]
        ),
        .plugin(
            name: "SwiftiomaticFormatPlugin",
            capability: .command(
                intent: .sourceCodeFormatting(),
                permissions: [
                    .writeToPackageDirectory(reason: "Formats Swift sources in place.")
                ]
            ),
            dependencies: [.target(name: "SmBinary")]
        ),
        .plugin(
            name: "SwiftiomaticLintPlugin",
            capability: .command(
                intent: .custom(
                    verb: "lint-source-code",
                    description: "Lint Swift source files with sm."
                )
            ),
            dependencies: [.target(name: "SmBinary")]
        ),
    ]
)
