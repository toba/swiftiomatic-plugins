# swiftiomatic-plugins

SwiftPM build-tool and command plugins for [Swiftiomatic](https://github.com/toba/swiftiomatic),
distributed as a thin wrapper around a prebuilt `sm` binary.

Adopting this package gives you the plugins **without compiling Swiftiomatic
from source** — no SwiftSyntax, no swift-markdown, no ArgumentParser pulled
into your dependency graph. The `sm` executable is downloaded as an
[artifact bundle](https://github.com/swiftlang/swift-package-manager/blob/main/Documentation/Reference/PackageDescription.md#binarytarget)
from the matching Swiftiomatic GitHub release, pinned by SHA256.

## Requirements

macOS 26 (Tahoe), Apple Silicon (`arm64`).

## Installation

Add the package to `Package.swift`:

```swift
.package(url: "https://github.com/toba/swiftiomatic-plugins", from: "0.31.12")
```

Attach plugins to the targets you want to lint or format:

```swift
.target(
    name: "MyApp",
    plugins: [
        .plugin(name: "SwiftiomaticBuildToolPlugin", package: "swiftiomatic-plugins"),
    ]
),
```

## Plugins

| Plugin | Capability | Verb | Effect |
|---|---|---|---|
| `SwiftiomaticBuildToolPlugin` | Build tool | (auto) | Lints the target Swift sources on every build (prebuild command). |
| `SwiftiomaticFormatPlugin` | Command | `swift package plugin format-source-code` | Formats Swift sources in place. Requires `--allow-writing-to-package-directory`. |
| `SwiftiomaticLintPlugin` | Command | `swift package plugin lint-source-code` | Lints Swift sources. Exits non-zero on any finding (`--strict`). |

Both command plugins accept `--target <name>` (repeatable) and
`--configuration <path>` to override the default `swiftiomatic.json` lookup.

## Smoke test

In a throwaway SPM package, depend on this package and attach
`SwiftiomaticBuildToolPlugin` to a target. The first build downloads the
artifact bundle (~MB) and resolves no other dependencies. Lint output appears
as part of the build log.

```swift
// Package.swift
.package(url: "https://github.com/toba/swiftiomatic-plugins", from: "0.31.12"),
```

```swift
.executableTarget(
    name: "SmokeTest",
    plugins: [
        .plugin(name: "SwiftiomaticBuildToolPlugin", package: "swiftiomatic-plugins"),
    ]
),
```

## Versioning

Tags here track the matching `sm` release. Version `0.31.12` of this package
points at `https://github.com/toba/swiftiomatic/releases/download/v0.31.12/sm.artifactbundle.zip`.
The Swiftiomatic release workflow updates the URL + checksum + tag here
automatically.

## License

Apache 2.0 with Runtime Library Exception, matching the upstream Swiftiomatic
project. See [LICENSE.txt](LICENSE.txt).
