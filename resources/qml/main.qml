import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

import Helpers 1.0

ApplicationWindow {
    id: root

    width: 500
    height: 600
    minimumWidth: 500
    visible: true
    color: Colors.backgroundSurface1
    title: qsTr("RobotechTestTaskClient")

    AppTheme {
        id: appTheme
    }

    header: Rectangle {
        width: parent.width
        height: 40
        color: Colors.backgroundSurface2

        Column {
            anchors.fill: parent

            RowLayout {
                width: parent.width

                Text {
                    leftPadding: 16
                    text: "Client"
                    font: Constants.heading1
                    color: Colors.textPrimary
                }

                Item {
                    Layout.fillWidth: true
                }

                ToolButton {
                    id: pinger
                    icon.source: "qrc:/img/notconnected.svg"
                    icon.color: pressed ? Colors.iconSecondary : Colors.iconBasic
                    background: Rectangle {
                        color: pinger.pressed ? Colors.iconFillPressed :
                                                pinger.hovered ? Colors.iconFillHover :
                                                                 Colors.transparent
                    }

                    Layout.minimumWidth: 40
                    Layout.minimumHeight: 40

                    onClicked: drawerPinger.open()
                }

                ToolButton {
                    id: notification
                    icon.source: "qrc:/img/settings.svg"
                    icon.color: pressed ? Colors.iconSecondary : Colors.iconBasic
                    background: Rectangle {
                        color: notification.pressed ? Colors.iconFillPressed :
                                                      notification.hovered ? Colors.iconFillHover :
                                                                             Colors.transparent
                    }

                    Layout.minimumWidth: 40
                    Layout.minimumHeight: 40

                    onClicked: drawerSettings.open()
                }
            }

            Separator { orientation: Qt.Horizontal }
        }
    }

    DrawerSettings {
        id: drawerSettings
    }

    DrawerPinger {
        id: drawerPinger
    }

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        GridLayout {
            rowSpacing: 8
            columnSpacing: 6
            anchors.right: parent.right

            Label {
                text: qsTr("IP")
                color: Colors.textSecondary
                font: Constants.heading2

                Layout.row: 0
                Layout.column: 0
            }

            Label {
                text: qsTr("Port")
                color: Colors.textSecondary
                font: Constants.heading2

                Layout.row: 0
                Layout.column: 1
            }

            TextField {
                id: ip

                text: tcpClientHandler ? tcpClientHandler.host : "0.0.0.0"
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
                Layout.preferredHeight: 32
                Layout.row: 1
                Layout.column: 0

                onTextChanged: {
                    if (!tcpClientHandler)
                        return

                    tcpClientHandler.host = text
                }
            }

            TextField {
                id: serverPort

                text: tcpClientHandler ? tcpClientHandler.port : "----"
                font: Constants.heading2
                validator: IntValidator {
                }
                color: Colors.textPrimary
                background: Rectangle {
                    color: Colors.backgroundTextArea
                    border.color: Colors.strokePrimary
                }

                Layout.preferredWidth: 80
                Layout.preferredHeight: 32
                Layout.row: 1
                Layout.column: 1

                onTextChanged: {
                    if (!tcpClientHandler)
                        return

                    tcpClientHandler.port = text
                }

            }

            Button {
                id: buttonConnect

                background: Rectangle {
                    implicitWidth: 128
                    implicitHeight: 32
                    border.color: Colors.strokePrimary
                    color: buttonConnect.pressed ? Colors.buttonPrimaryFillPressed :
                                                buttonConnect.hovered ? Colors.buttonPrimaryFillHover :
                                                                     !buttonConnect.enabled ? Colors.buttonFillDisabled :
                                                                                           Colors.buttonPrimaryFillDefault
                }
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    RowLayout {
                        anchors.centerIn: parent
                        height: parent.height

                        Text {
                            id: name1
                            text: qsTr("Connect")
                            font: Constants.heading2
                            color: Colors.textPrimary
                        }
                    }
                }

                Layout.row: 1
                Layout.column: 2

                onPressed: {
                    tcpClientHandler.connectToServer()
                }
            }

            Button {
                id: buttonDisconnect

                enabled: false
                background: Rectangle {
                    implicitWidth: 128
                    implicitHeight: 32
                    border.color: Colors.strokePrimary
                    color: buttonDisconnect.pressed ? Colors.buttonPrimaryFillPressed :
                                                buttonDisconnect.hovered ? Colors.buttonPrimaryFillHover :
                                                                     !buttonDisconnect.enabled ? Colors.buttonFillDisabled :
                                                                                           Colors.buttonPrimaryFillDefault
                }
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    RowLayout {
                        anchors.centerIn: parent
                        height: parent.height

                        Text {
                            text: qsTr("Disconnect")
                            font: Constants.heading2
                            color: Colors.textPrimary
                        }
                    }
                }

                Layout.row: 1
                Layout.column: 3

                onPressed: {
                    tcpClientHandler.disconnectFromServer()
                }
            }


            Item {
                Layout.fillWidth: true
                Layout.row: 0
                Layout.column: 3
            }

            Connections {
                target: tcpClientHandler

                function onConnected() {
                    buttonConnect.enabled = false
                    buttonDisconnect.enabled = true
                    buttonSend.enabled = true
                }

                function onDisconnected() {
                    buttonConnect.enabled = true
                    buttonDisconnect.enabled = false
                    buttonSend.enabled = false
                }
            }
        }

        Text {
            topPadding: 16
            text: qsTr("Input text:")
            color: Colors.textSecondary
            font: Constants.heading2
        }

        Rectangle {
            width: parent.width
            height: root.height * 0.2

            ScrollView {
                anchors.fill: parent
                TextArea {
                    id: textSend

                    color: Colors.textSecondary
                    font: Constants.textArea
                    wrapMode: TextEdit.WordWrap
                    background: Rectangle {
                        color: Colors.backgroundTextArea
                        border.color: Colors.strokePrimary
                    }
                    onTextChanged: {
                        if (text.length > 1000) {
                            text = text.substring(0, 1000)
                        }
                    }
                }
            }
        }

        Button {
            id: buttonSend

            enabled: false
            anchors.right: parent.right
            background: Rectangle {
                implicitWidth: 128
                implicitHeight: 32
                border.color: Colors.strokePrimary
                color: buttonSend.pressed ? Colors.buttonPrimaryFillPressed :
                                            buttonSend.hovered ? Colors.buttonPrimaryFillHover :
                                                                 !buttonSend.enabled ? Colors.buttonFillDisabled :
                                                                                       Colors.buttonPrimaryFillDefault
            }
            contentItem: Rectangle {
                anchors.fill: parent
                color: "transparent"

                RowLayout {
                    anchors.centerIn: parent
                    height: parent.height

                    Text {
                        //id: name
                        text: qsTr("Send")
                        font: Constants.heading2
                        color: Colors.textPrimary
                    }
                }
            }

            onPressed: {
                if (tcpClientHandler && textSend.text != "")
                    tcpClientHandler.sendMessage(textSend.text)
                textSend.text = ""
            }
        }

    }

    footer: Rectangle {
        width: parent.width
        height: 64
        color: Colors.backgroundSurface2

        Separator { orientation: Qt.Horizontal }

        RowLayout {
            anchors.fill: parent

            ListView {
                id: logView

                spacing: 4
                model: transferDataHandler ? transferDataHandler.serviceDataList : {}
                delegate: Text {
                    text: modelData
                    font.pixelSize: 12
                    color: Colors.textPrimary
                }
                clip: true

                Layout.margins: 8

                Layout.fillHeight: true
                Layout.fillWidth: true

                onCountChanged: {
                    if (count > 0) {
                        logView.positionViewAtEnd();
                    }
                }
            }

        }
    }

    Component.onCompleted: {
        appTheme.setDarkTheme()
        tcpClientHandler.connectToServer()
    }

}
