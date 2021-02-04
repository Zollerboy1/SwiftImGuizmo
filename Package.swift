// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImGuizmo",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ImGuizmo",
            targets: ["ImGuizmo"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Zollerboy1/ImGui.git", from: "2.1.3"),
        .package(name: "SGLMath", url: "https://github.com/Zollerboy1/Math.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "cppImGuizmo",
            dependencies: [.product(name: "cppImGui", package: "ImGui")],
            exclude: ["imgui/docs", "imgui/examples", "imgui/misc", "imgui/imconfig.h", "imgui/imgui_demo.cpp", "imgui/imgui_draw.cpp", "imgui/imgui_widgets.cpp", "imgui/imgui.cpp", "imgui/imgui_rectpack.h", "imgui/imgui_truetype.h", "imgui/LICENSE.txt", "imguizmo/bin", "imguizmo/example", "imguizmo/ImCurveEdit.cpp", "imguizmo/ImCurveEdit.h", "imguizmo/ImGradient.cpp", "imguizmo/ImGradient.h", "imguizmo/ImSequencer.cpp", "imguizmo/ImSequencer.h", "imguizmo/ImZoomSlider.h", "imguizmo/LICENSE", "imguizmo/README.md", "include/cppimguizmo.hpp"],
            sources: ["imguizmo/ImGuizmo.cpp"],
            cxxSettings: [.headerSearchPath("imguizmo"), .headerSearchPath("imgui")]),
        .target(
            name: "cImGuizmo",
            dependencies: [
                "cppImGuizmo",
                .product(name: "cImGui", package: "ImGui"),
                .product(name: "cppImGui", package: "ImGui")
            ]),
        .target(
            name: "ImGuizmo",
            dependencies: ["cImGuizmo", "ImGui", "SGLMath"]),
        .testTarget(
            name: "ImGuizmoTests",
            dependencies: ["ImGuizmo"]),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx11
)
