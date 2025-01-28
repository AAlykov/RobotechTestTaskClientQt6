pragma Singleton

import QtQuick 2.15

QtObject {
    readonly property font heading1: Qt.font({
        weight: Font.Medium,
        pixelSize: 16,
        letterSpacing: 2,
        capitalization: Font.AllUppercase
    })

    readonly property font heading11: Qt.font({
        weight: Font.Medium,
        pixelSize: 14,
        letterSpacing: 2,
        capitalization: Font.AllUppercase
    })

    readonly property font heading2: Qt.font({
        weight: Font.Medium,
        pixelSize: 12,
        letterSpacing: 0.5,
        capitalization: Font.AllUppercase
    })

    readonly property font heading21: Qt.font({
        weight: Font.Medium,
        pixelSize: 10,
        letterSpacing: 0.5,
        capitalization: Font.AllUppercase
    })

    readonly property font heading3: Qt.font({
        weight: Font.Medium,
        pixelSize: 10,
        letterSpacing: 0.5,
        capitalization: Font.AllUppercase
    })
    readonly property font link: Qt.font({
        pixelSize: 12,
        letterSpacing: 0.5,
        underline: true
    })
    readonly property font linkReport: Qt.font({
        pixelSize: 14,
        letterSpacing: 0.5,
        underline: true
    })
    readonly property font tab: Qt.font({
        pixelSize: 11,
        letterSpacing: 0.5
    })
    readonly property font textArea: Qt.font({
        pixelSize: 14,
        letterSpacing: 1.5,
    })
    readonly property font textAreaPing: Qt.font({
        pixelSize: 12,
        //letterSpacing: 0.5,
    })
}
