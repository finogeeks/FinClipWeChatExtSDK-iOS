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
            url: "https://app.finogeeks.com/finchat/sdk/FinAppletWXExt_---VERSION_PLACEHOLDEER---.xcframework.zip",
            checksum: "---CHECKSUM_PLACEHOLDER---"
        ),
    ]
)
