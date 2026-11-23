import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#F4F6F8"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Профиль пользователя"
            font.pixelSize: 36
            font.bold: true
            color: "#3EB489"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Здесь будет статистика."
            font.pixelSize: 18
            color: "#2E3856"
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
