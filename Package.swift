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
            url: "https://github.com/toba/swiftiomatic/releases/download/4.5.4/sm.artifactbundle.zip",
            checksum: "9da74767e75da7422938fbd9529fd8dd612adc5f3513055096db3f2f3158e6da"
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
