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

    Item {
        width: parent.width
        height: 0

        property real realHeight: parent.contentHeight - parent.height
        property real relativePosition: parent.contentPosition / realHeight

        y: parent.height * relativePosition

        Rectangle {
            width: scrollBarContainer.width
            height: _RES.s_ICON_SIZE
            color: Style.Background.OVERLAY
            anchors.verticalCenter: parent.verticalCenter
            transformOrigin: Item.Center
        }
    }

}

