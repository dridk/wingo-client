import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style

Item {
    id: checkmark
    width: _RES.s_LIST_ITEM_HEIGHT
    height: width

    property bool checked: false

    function toggle (state) {
        state = state || !checked;
        checked = state;
    }

    Icon{
        size: _RES.s_ICON_SIZE_SMALL
        name: checkmark.checked? Icons.CHECKMAK_FULL : Icons.CHECKMAK_BLANK
        anchors.centerIn: parent
        color: checkmark.checked? Style.Icon.ACCENT : Style.Icon.FADE
    }

    MouseArea {
        anchors.fill: parent
        onClicked: toggle()
    }
}
