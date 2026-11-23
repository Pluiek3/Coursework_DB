import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property string title: ""
    signal clicked()

    Layout.fillWidth: true
    height: 40
    radius: 8
    color: "transparent"

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 25
        text: root.title
        color: "#2E3856"
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.color = "#E2E8F0"
        onExited: parent.color = "transparent"
        onClicked: root.clicked()
    }
}
