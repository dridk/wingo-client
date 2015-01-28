import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style

Text {
    font.pixelSize: _RES.s_TEXT_SIZE_MEDIUM || 24
    textFormat: Text.RichText
    font.family: "Droid Sans"
    color: Style.Typography.TEXT
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignLeft
}
