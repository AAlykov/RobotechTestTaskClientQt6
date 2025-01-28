import QtQuick 2.10

import Helpers 1.0

QtObject
{
    function setLightTheme() {
        Colors.isDark = false
    }

    function setDarkTheme() {
        Colors.isDark = true
    }
}
