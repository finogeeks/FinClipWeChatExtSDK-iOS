// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "FinAppletWXExt",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "FinAppletWXExt",
            targets: ["FinAppletWXExt"]),
    ],
    targets: [
        .binaryTarget(
            name: "FinAppletWXExt",
            url: "https://app.finogeeks.com/finchat/sdk/FinAppletWXExt-___VERSION_PLACEHOLDER___.zip",
            checksum: "___CHECKSUM_PLACEHOLDER___"
        ),
    ]
)
