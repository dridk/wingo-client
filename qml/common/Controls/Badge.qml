import QtQuick 2.0

import "../../scripts/Utilities.js" as Utilities
import "../../scripts/NumberFormat.js" as NumberFormat
import "../../scripts/AppStyle.js" as Style

Rectangle {
    id: badge
    width: Math.max(U.px(24), childrenRect.width + _RES.s_DOUBLE_MARGIN)
    height: childrenRect.height + _RES.s_MARGIN
    radius: height / 2

    property int value: 0
    property string style: 'DEFAULT'
    property bool showZeroValue: false

    color: Style.Background.Badge[style]

    visible: Utilities.isNumber(value) && (showZeroValue || !NumberFormat.isZero(value))

    Label{
        x: _RES.s_MARGIN
        y: x / 2
        id: badgeLabel
        text: NumberFormat.toReadableString(badge.value)
        font.pixelSize: _RES.s_TEXT_SIZE_MINI
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: Style.Typography.Badge[badge.style]
    }
}
