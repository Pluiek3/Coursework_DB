import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#F4F6F8"

    signal moduleClicked(int moduleId, string moduleName)

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 20

        Text {
            text: "Словарь: " + backend.currentDictionaryName
            font.pixelSize: 36; font.bold: true; color: "#2E3856"
        }

        Text { text: "Выберите модуль для изучения:"; font.pixelSize: 18; color: "#718096" }

        GridView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            cellWidth: 200
            cellHeight: 120
            clip: true
            model: backend.dictionaryModules

            delegate: Rectangle {
                width: 180; height: 100; radius: 12
                color: "#FFFFFF"
                border.color: "#E2E8F0"

                Text {
                    anchors.centerIn: parent
                    text: modelData.name
                    font.pixelSize: 18; font.bold: true; color: "#3EB489"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.border.color = "#3EB489"
                    onExited: parent.border.color = "#E2E8F0"
                    onClicked: root.moduleClicked(modelData.id, modelData.name)
                }
            }
        }
    }
}
