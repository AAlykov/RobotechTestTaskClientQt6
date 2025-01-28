import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

import Helpers 1.0

Drawer {
    id: drawer
    width: 320
    height: parent.height - 64
    modal: true
    edge: Qt.RightEdge
    background: Rectangle {
        color: Colors.backgroundSurface1
    }

    clip: true

    Overlay.modal: Rectangle {
        color: Colors.makeColorWithAlpha(Colors.overlayColor, 0.8)
    }

    Rectangle {
        anchors.fill: parent
        color: Colors.backgroundSurface2

        ColumnLayout {
            spacing: 10

            anchors.fill: parent

            RowLayout {
                Layout.preferredHeight: 14
                Layout.preferredWidth: parent.width
                Layout.rightMargin: 8
                Layout.leftMargin: 8
                Layout.topMargin: 10

                Label {
                    text: qsTr("Settings")
                    font: Constants.heading11
                    color: Colors.textPrimary

                    Layout.alignment: Qt.AlignLeft
                }

                ToolButton {
                    id: close

                    icon.source: "qrc:/img/close.svg"
                    icon.color: pressed ? Colors.iconSecondary : Colors.iconBasic
                    background: Rectangle {
                        color: close.pressed ? Colors.iconFillPressed :
                                                  close.hovered ? Colors.iconFillHover :
                                                                     Colors.transparent
                    }

                    icon.width: 14
                    icon.height: 14

                    Layout.alignment: Qt.AlignRight

                    onClicked: drawer.close()
                }
            }

            Separator { orientation: Qt.Horizontal }

            RowLayout {
                Layout.preferredHeight: 14

                Layout.rightMargin: 8
                Layout.leftMargin: 8
                Layout.topMargin: 10

                Label {
                    text: qsTr("Dark mode")
                    font: Constants.heading2
                    color: Colors.textPrimary
                }

                Switch {
                    id: themeSwitch

                    checked: false
                    LayoutMirroring.enabled: true
                    Layout.alignment: Qt.AlignRight

                    onCheckedChanged: {
                        if (checked)
                            appTheme.setLightTheme()
                        else
                            appTheme.setDarkTheme()
                    }
                }


            }

            Item {
                Layout.fillHeight: true
            }

        }
    }
}

