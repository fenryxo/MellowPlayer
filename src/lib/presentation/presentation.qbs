import qbs
import qbs.Probes
import qbs.TextFile
import Settings

Product {
    id: product

    name: "MellowPlayer.Presentation"
    type: platform.libraryType

    cpp.includePaths: [ product.sourceDirectory + "/include" ]
    cpp.cxxLanguageVersion: platform.cxxLanguageVersion

    property bool hasLibnotify: product.libnotify !== undefined && product.libnotify.found

    Group {
        name: "Imports"
        files: ["imports/imports.qrc", "**/*.qml", "**/*.js"]
    }

    Group {
        name: "Sources"
        files: [
            "src/*.cpp",
            "src/*/*.cpp",
            "src/Notifications/Presenters/*.cpp",
            "src/ViewModels/*/*.cpp",
            "src/ViewModels/*/*/*.cpp",
        ]

        Group {
            name: "MPRIS Sources"
            files: [
                "src/Mpris/Linux/*.cpp"
            ]
            condition: product.platform.unix
        }

        Group {
            name: "Libnotify Presenter Sources"
            files: [
                "src/Notifications/Presenters/Linux/*.cpp"
            ]
            condition: product.hasLibnotify
        }
    }

    Group {
        name: "Headers"
        files: [
            "include/MellowPlayer/Presentation/*.hpp",
            "include/MellowPlayer/Presentation/*/*.hpp",
            "include/MellowPlayer/Presentation/Notifications/Presenters/*.hpp",
            "include/MellowPlayer/Presentation/ViewModels/*/*.hpp",
            "include/MellowPlayer/Presentation/ViewModels/*/*/*.hpp",
        ]

        Group {
            name: "MPRIS Headers"
            files: [
                "include/MellowPlayer/Presentation/Mpris/Linux/*.hpp"
            ]
            condition: product.platform.unix
        }

        Group {
            name: "Libnotify Presenter Headers"
            files: [
                "include/MellowPlayer/Presentation/Notifications/Presenters/Linux/*.hpp"
            ]
            condition: product.hasLibnotify
        }
    }

    Group {
        name: "Resources"
        files: "resources/presentation.qrc"
    }

    Group {
        name: "Library"
        fileTagsFilter: "dynamiclibrary"
        qbs.install: true
        qbs.installDir: project.libDir
    }

    Depends { name: 'cpp' }
    Depends { name: "platform"}
    Depends { name: "Qt.core" }
    Depends { name: "Qt.concurrent" }
    Depends { name: "Qt.widgets" }
    Depends { name: "Qt.network" }
    Depends { name: "Qt.webengine" }
    Depends { name: "Qt.sql" }
    Depends { name: "Qt.dbus"; condition: platform.unix }
    Depends { name: 'MellowPlayer.Domain' }
    Depends { name: 'MellowPlayer.Infrastructure' }
    Depends { name: 'qxtglobalshortcut' }
    Depends { name: "SettingsTranslator.js" }
    Depends { name: "libnotify"; condition: platform.unix }

    Export {
        Depends { name: "platform"}
        Depends { name: 'cpp' }
        Depends { name: "Qt.core" }
        Depends { name: "Qt.concurrent" }
        Depends { name: "Qt.widgets" }
        Depends { name: "Qt.network" }
        Depends { name: "Qt.webengine" }
        Depends { name: "Qt.webenginewidgets" }
        Depends { name: "Qt.sql" }
        Depends { name: "Qt.dbus"; condition: platform.unix }
        Depends { name: 'MellowPlayer.Domain' }
        Depends { name: 'MellowPlayer.Infrastructure' }
        Depends { name: 'qxtglobalshortcut' }

        cpp.includePaths: product.cpp.includePaths
    }
}