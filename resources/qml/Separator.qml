import QtQuick 2.15
import Helpers 1.0

Rectangle {
    required property int orientation
    readonly property bool horizontal: orientation === Qt.Horizontal
    readonly property bool vertical: orientation === Qt.Vertical

    implicitWidth: horizontal ? parent.width : 1
    implicitHeight: vertical ? parent.height : 1

    color: Colors.strokePrimary
}
