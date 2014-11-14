import QtQuick 2.0

import "../../scripts/NumberFormat.js" as NumberFormat

Rectangle {
    id: badge
    width: Math.max(_RES.scale(24), badgeLabel.width + _RES.s_DOUBLE_MARGIN)
    height: _RES.scale(24)
    radius: height / 2

    property int value: 0

    Label{
        id: badgeLabel
        text: NumberFormat.toString(parent.value)
        font.pixelSize: _RES.s_TEXT_SIZE_SMALL
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
    }
}
