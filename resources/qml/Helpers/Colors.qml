pragma Singleton

import QtQuick 2.15

QtObject {
    property bool isDark

    readonly property color transparent: "transparent"

    readonly property color backgroundSurface1: colorByTheme({dark: "#1A1A1A", light: "#F5F5F5"})
    readonly property color backgroundSurface2: colorByTheme({dark: "#202020", light: "#EFECEC"})
    readonly property color backgroundSurface3: colorByTheme({dark: "#454545", light: "#DCDCDC"})

    readonly property color textPrimary: colorByTheme({dark: "#F0F0F0", light: "#303030"})
    readonly property color textSecondary: colorByTheme({dark: "#D4D4D4", light: "#4A4A4A"})

    readonly property color iconBasic: colorByTheme({dark: "#FFFFFF", light: "#000000"})
    readonly property color iconPrimary: colorByTheme({dark: "#F0F0F0", light: "#303030"})
    readonly property color iconSecondary: colorByTheme({dark: "#D4D4D4", light: "#4A4A4A"})

    readonly property color basic_100: colorByTheme({dark: "#FFFFFF", light: "#000000"})
    readonly property color iconFillPressed: colorByTheme({dark: makeColorWithAlpha(basic_100, 0.04), light: makeColorWithAlpha(basic_100, 0.08)})
    readonly property color iconFillHover: colorByTheme({dark: makeColorWithAlpha(basic_100, 0.1), light: makeColorWithAlpha(basic_100, 0.15)})

    readonly property color backgroundTextArea: colorByTheme({dark: "#454545", light: "#DCDCDC"})

    readonly property color overlayColor: colorByTheme({dark:"#181818", light:"#181818"});

    // Stroke
    readonly property color strokePrimary: colorByTheme({dark: "#454545", light: "#D4D4D4"})
    readonly property color strokeSecondary: colorByTheme({dark: "#3C3C3C", light: "#E4E4E4"})

    //Button
    readonly property color buttonPrimaryFillDefault: colorByTheme({dark: "#3C3C3C", light: "#DCDCDC"})
    readonly property color buttonPrimaryFillHover: colorByTheme({dark: "#454545", light: "#E7E7E7"})
    readonly property color buttonPrimaryFillPressed: colorByTheme({dark: "#3C3C3C", light: "#DCDCDC"})
    readonly property color buttonFillDisabled: colorByTheme({dark: "#222222", light: "#EFECEC"})


    function colorByTheme(setup) {
        return isDark ? setup.dark : setup.light
    }

    function makeColorWithAlpha(color, alpha) {
        return Qt.rgba(color.r, color.g, color.b, alpha)
    }

}
