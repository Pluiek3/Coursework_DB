import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property string icon: ""
    property string title: ""
    signal clicked()

    Layout.fillWidth: true
    height: 44
    radius: 8
    color: "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        spacing: 10
        Text { text: root.icon; font.pixelSize: 16 }
        Text { text: root.title; font.pixelSize: 16; color: "#2E3856"; font.bold: true }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.color = "#E2E8F0"
        onExited: parent.color = "transparent"
        onClicked: root.clicked()
    }
}
