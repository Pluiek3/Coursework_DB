import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#F6F7FB"
    border.color: "#E2E8F0"
    border.width: 1

    signal viewRequested(string viewName)
    property bool isModulesExpanded: true
    
    property color titleColor: "#3EB489"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 8

        Text {
            text: "Slovníček"
            font.pixelSize: 24; font.bold: true; 
            color: root.titleColor 
            Layout.bottomMargin: 10
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#E2E8F0"; Layout.bottomMargin: 10 }

        
        NavItem { 
            title: "Главная"; 
            onClicked: root.viewRequested("home") 
        }

        NavItem { 
   	    title: "Профиль"; 
            onClicked: root.viewRequested("profile") 
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: "#E2E8F0"; Layout.topMargin: 10; Layout.bottomMargin: 10 }

        //Модули
        Rectangle {
            Layout.fillWidth: true
            height: 36
            radius: 8
            color: "transparent"
            
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 5
                spacing: 5
                
                Text { 
                    text: "▶"
                    font.pixelSize: 12
                    color: "#718096"
                    rotation: root.isModulesExpanded ? 90 : 0
                    Behavior on rotation { NumberAnimation { duration: 150 } }
                }
                
                Text { 
                    text: "Словари"; 
                    color: "#718096"; 
                    font.pixelSize: 14; 
                    font.bold: true 
                }
            }
            
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.color = "#E2E8F0"
                onExited: parent.color = "transparent"
                onClicked: root.isModulesExpanded = !root.isModulesExpanded
            }
        }

        // Список модулей
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4
            visible: root.isModulesExpanded

            Repeater {
                model: backend.modules
                delegate: ModuleItem {
                    title: modelData
                    onClicked: {
                        backend.selectModule(modelData)
                        root.viewRequested("module")
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
