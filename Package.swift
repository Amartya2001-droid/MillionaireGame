// swift-tools-version: 5.9
import PackageDescription

// Only Foundation game logic is portable; this does not build the SwiftUI app.
let package = Package(
    name: "MillionaireGameLogic",
    products: [.library(name: "MillionaireGame", targets: ["MillionaireGame"])],
    targets: [
        .target(
            name: "MillionaireGame",
            path: "MillionaireGame",
            exclude: ["Assets.xcassets", "Preview Content", "ContentView.swift",
                      "DesignSystem.swift", "GameFlowViews.swift", "MillionaireGameApp.swift"],
            sources: ["GameRules.swift", "Models.swift", "QuestionBank.swift"]
        ),
        .testTarget(name: "MillionaireGameTests", dependencies: ["MillionaireGame"], path: "MillionaireGameTests")
    ]
)
