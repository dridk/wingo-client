import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style

Item {
    id: icon
    width: _RES.scale(48) || 48
    height: _RES.scale(48) || 48

    property alias name: glyph.text
    property alias color: glyph.color

    Text {
        id: glyph
        color: Style.Typography.TEXT
        lineHeight: 1
        font.family: "Icon Font"
        font.pixelSize: parent.width
        textFormat: Text.PlainText
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
