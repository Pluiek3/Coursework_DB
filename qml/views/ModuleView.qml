import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#F4F6F8"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 20

        Text {
            text: "Модуль: " + backend.currentModuleName
            font.pixelSize: 36; font.bold: true; color: "#2E3856"
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 10
            model: backend.moduleCards

            delegate: Rectangle {
                width: ListView.view.width; height: 70
                radius: 8; color: "#FFFFFF"
                border.color: "#E2E8F0"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    
                    Text {
                        text: modelData.term
                        font.pixelSize: 20; font.bold: true; color: "#2E3856"
                        Layout.fillWidth: true
                    }
                    Text {
                        text: modelData.translation
                        font.pixelSize: 20; color: "#3EB489"
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
