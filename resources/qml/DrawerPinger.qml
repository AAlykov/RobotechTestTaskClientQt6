import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

import Helpers 1.0

Drawer {
    id: drawer
    width: 400
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
                    text: qsTr("Pinger")
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

            GridLayout {
                rowSpacing: 4
                columnSpacing: 4
                Layout.preferredHeight: 14
                Layout.rightMargin: 8
                Layout.leftMargin: 8
                Layout.topMargin: 16

                Label {
                    text: qsTr("IP")
                    font: Constants.heading2
                    color: Colors.textPrimary

                    Layout.row: 0
                    Layout.column: 0
                }

                Label {
                    text: qsTr("Count")
                    font: Constants.heading2
                    color: Colors.textPrimary

                    Layout.row: 0
                    Layout.column: 1
                }

                Label {
                    text: qsTr("Size")
                    font: Constants.heading2
                    color: Colors.textPrimary

                    Layout.row: 0
                    Layout.column: 2
                }

                TextField {
                    id: ip

                    property string defaultAddress: "192.168.1.1"

                    text: defaultAddress
                    font: Constants.heading2
                    validator: RegularExpressionValidator {
                        regularExpression:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
                    }

                    color: Colors.textPrimary
                    background: Rectangle {
                        color: Colors.backgroundTextArea
                        border.color: Colors.strokePrimary
                    }

                    Layout.preferredWidth: 128
                    Layout.preferredHeight: 30
                    Layout.row: 1
                    Layout.column: 0
                }

                TextField {
                    id: count

                    text: "10"
                    font: Constants.heading2
                    validator: IntValidator {
                    }
                    color: Colors.textPrimary
                    background: Rectangle {
                        color: Colors.backgroundTextArea
                        border.color: Colors.strokePrimary
                    }

                    Layout.preferredWidth: 58
                    Layout.preferredHeight: 30
                    Layout.row: 1
                    Layout.column: 1

                }

                TextField {
                    id: size

                    text: "256"
                    font: Constants.heading2
                    validator: RegularExpressionValidator {
                        regularExpression:  /^(65500|6550[0-9]|65[0-4][0-9]{2}|6[0-4][0-9]{3}|[1-9][0-9]{0,3})$/
                    }
                    color: Colors.textPrimary
                    background: Rectangle {
                        color: Colors.backgroundTextArea
                        border.color: Colors.strokePrimary
                    }

                    Layout.preferredWidth: 58
                    Layout.preferredHeight: 30
                    Layout.row: 1
                    Layout.column: 2
                }

                Button {
                    id: buttonPing

                    background: Rectangle {
                        implicitWidth: 128
                        implicitHeight: 32
                        border.color: Colors.strokePrimary
                        color: buttonPing.pressed ? Colors.buttonPrimaryFillPressed :
                                                    buttonPing.hovered ? Colors.buttonPrimaryFillHover :
                                                                         !buttonPing.enabled ? Colors.buttonFillDisabled :
                                                                                               Colors.buttonPrimaryFillDefault
                    }
                    contentItem: Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        RowLayout {
                            anchors.centerIn: parent
                            height: parent.height

                            Text {
                                id: name
                                text: qsTr("Ping")
                                font: Constants.heading2
                                color: Colors.textPrimary
                            }
                        }
                    }

                    Layout.row: 1
                    Layout.column: 3

                    onPressed: {
                        transferDataHandler.ping(ip.text, count.text, size.text)
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.row: 0
                    Layout.column: 3
                }
            }

            RowLayout {
                Layout.rightMargin: 8
                Layout.leftMargin: 8

                Rectangle {

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ScrollView {
                        anchors.fill: parent
                        TextArea {
                            text: transferDataHandler ? transferDataHandler.transferDataPing : ""
                            color: Colors.textSecondary
                            font: Constants.textAreaPing
                            wrapMode: TextEdit.WordWrap
                            background: Rectangle {
                                color: Colors.backgroundTextArea
                                border.color: Colors.strokePrimary
                            }
                        }
                    }

                    Layout.preferredHeight: 128
                }
            }

            Item {
                Layout.fillHeight: true
            }

        }
    }
}

