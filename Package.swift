// swift-tools-version:5.1
import PackageDescription

let package = Package(
	name: "kap-recording-time",
	platforms: [
		.macOS(.v10_12)
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "0.1.0")
	],
	targets: [
		.target(
			name: "kap-recording-time",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser")
			]
		)
	]
)