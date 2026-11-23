import QtQuick

Rectangle {
    property alias text: btnText.text
    signal clicked()

    width: 180; height: 120; radius: 12
    color: "#FFFFFF"
    border.color: "#E2E8F0"

    Text {
        id: btnText
        anchors.centerIn: parent
        font.bold: true; color: "#3EB489"; font.pixelSize: 18
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
