// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

struct PackageMetadata {
    static let version: String = "0.9.40-beta.1"
    static let checksum: String = "d939888f60abcba149cce33a1e33649425a70a7c6ef0ae6bb6627190414a4d0a"
}

let package = Package(
    name: "SRAVVPlayer",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "SRAVVPlayer", targets: ["SRAVVPlayerTarget"])
    ],
    dependencies: [
        .package(url: "https://github.com/yahoojapan/SwiftyXMLParser.git", .upToNextMajor(from: "5.6.0")),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", .upToNextMajor(from: "5.19.0")),
        .package(url: "https://github.com/googleads/swift-package-manager-google-interactive-media-ads-ios", .upToNextMajor(from: "3.22.1")),
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "6.7.0")),
    ],
    targets: [
        .target(name: "SRAVVPlayerTarget",
                dependencies: [    .target(name: "SRAVVPlayer_Binary"),
                                   .target(name: "GoogleCast"),
                                   .product(name: "GoogleInteractiveMediaAds", package: "swift-package-manager-google-interactive-media-ads-ios"),
                                   .product(name: "SDWebImage", package: "SDWebImage"),
                                   .product(name: "SwiftyXMLParser", package: "SwiftyXMLParser"),
                                   .product(name: "RxSwift", package: "RxSwift"),
                                   .product(name: "RxCocoa", package: "RxSwift"),
                ]),
        
            .binaryTarget(
                name: "SRAVVPlayer_Binary",
                url: "https://github.com/sportradar/SR_AVVPlayer_iOS/releases/download/\(PackageMetadata.version)/AVVPlayer-MARVIN.zip",
                checksum: PackageMetadata.checksum
            ),
        
            .binaryTarget(
                name: "GoogleCast",
                path: "ThirdParty/GoogleCast/4.8.1/GoogleCast.zip"
            )
    ]
)


