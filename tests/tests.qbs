import qbs

Project {
    property string main: sourceDirectory + "/tests/main.cpp"
    property var includePaths: [
        sourceDirectory + "/3rdparty",
        sourceDirectory + "/tests",
        sourceDirectory + "/tests/Lib"
    ]

    condition: project.buildTests
    name: "Tests"
    references: [
        "Lib/Lib.qbs",
        "UnitTests/unittests.qbs"
    ]
}