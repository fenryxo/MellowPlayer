import QtQuick 2.9
import QtQuick.Controls 2.2

ToolTip {
    id: tooltip

    property string shortcut: ""

    visible: parent !== undefined ? parent.hovered : false
    delay: 1000
    timeout: 5000
    y: parent.implicitHeight
    x: 0

    contentItem: Text {
        text: tooltip.text + (shortcut != "" ? " (" + shortcut + ")" : "")
        font: tooltip.font
        color: "white"
    }

    background: Rectangle {
        color: "#606060"
        opacity: 0.9
        radius: 2
    }
}
