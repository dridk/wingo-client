import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style

Item {
    id: scrollBarContainer
    width: _RES.s_MARGIN
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    property int contentHeight: 0
    property int contentPosition: 0

    Rectangle {

        property real realHeight: parent.contentHeight - parent.height - height
        property real relativePosition: parent.contentPosition / realHeight

        y: parent.height * relativePosition
        width: _RES.s_BORDER
        height: _RES.s_ICON_SIZE
        anchors.horizontalCenter: parent.horizontalCenter
        color: Style.Background.OVERLAY

    }

}

