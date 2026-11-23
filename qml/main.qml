import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"
import "views"

ApplicationWindow {
    visible: true
    width: 1100
    height: 700
    title: "Slovníček"

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Sidebar {
            Layout.preferredWidth: 260
            Layout.fillHeight: true
            
            onViewRequested: (viewName) => {
                if (viewName === "home") {
                    mainStack.replace(homeViewComp)
                } else if (viewName === "profile") {
                    mainStack.replace(profileViewComp)
                } else if (viewName === "module") {
                    console.log("Выбран модуль: " + backend.currentModule)
                }
            }
        }

        StackView {
            id: mainStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            initialItem: homeViewComp
            
            clip: true 

            replaceEnter: Transition {
                NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 250; easing.type: Easing.OutQuad }
            }
            replaceExit: Transition {
                NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 250; easing.type: Easing.OutQuad }
            }
        }
    }

    
    Component { 
        id: homeViewComp 
        HomeView {} 
    }
    
    Component { 
        id: profileViewComp 
        ProfileView {} 
    }
}
