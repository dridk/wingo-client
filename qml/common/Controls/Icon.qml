import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style

Item {
    id: icon
    width: size
    height: size

    property int size: _RES.s_ICON_SIZE
    property alias name: glyph.text
    property alias color: glyph.color
    property alias iconStyle: glyph.style
    property alias iconStyleColor: glyph.styleColor

    Text {
        id: glyph
        color: Style.Icon.DEFAULT
        lineHeight: 1
        font.family: "wingo"
        font.pixelSize: parent.width
        textFormat: Text.PlainText
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        z: 1
    }
}
