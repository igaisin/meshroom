import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import "layouts"
import "headers"
import "components"
import "delegates"

TitledPageLayout {

    id: root

    background: DefaultBackground {}
    header: Item {}
    body: Item {
        anchors.fill: parent
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        ColumnLayout {
            anchors.fill: parent
            spacing: 10
            Item { // spacer
                Layout.fillHeight: true
            }
            CustomText {
                text: "Open"
                textSize: _style.text.size.xlarge
                color: _style.text.color.darker
            }
            MouseArea {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 30
                onClicked: fileDialog.open()
                RowLayout {
                    anchors.fill: parent
                    CustomToolButton {
                        iconSource: "qrc:///images/project.svg"
                        iconSize: _style.icon.size.small
                        enabled: false
                    }
                    Item {
                        Layout.fillWidth: true
                        CustomWrappedText {
                            anchors.centerIn: parent
                            width: parent.width
                            text: "New location..."
                        }
                    }
                }
            }
            CustomText {
                text: "Featured projects"
                textSize: _style.text.size.normal
                color: _style.text.color.darker
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 90
                color: _style.window.color.xdarker
                ListView {
                    anchors.fill: parent
                    anchors.margins: 4
                    spacing: 2
                    clip: true
                    model: _applicationModel.featured
                    delegate: UrlDelegate {}
                }
            }
            Item { // spacer
                Layout.fillHeight: true
            }
        }
    }

    // file dialog
    FileDialog {
        id: fileDialog
        title: "Please choose a project directory"
        folder: "/"
        selectFolder: true
        selectMultiple: false
        sidebarVisible: false
        onAccepted: _applicationModel.projects.addProject(fileDialog.fileUrl)
    }

}