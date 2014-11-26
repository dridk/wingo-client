import QtQuick 2.0
import Wingo 1.0

import "../../scripts/AppStyle.js" as Style

Item{
    id: tagItem
    width: tagRow.width
    height: tagLabel.height + _RES.s_MARGIN

    property alias text: tagLabel.text
    property string style: "DEFAULT"

    Row{
        id: tagRow

        PolygonItem {
            width: _RES.s_MARGIN
            height: tagItem.height
            color: tagBody.color
            points:[[0, height*0.5], [width,0], [width,height]]
        }
        Rectangle {
            id: tagBody
            width: Math.max(_RES.s_ICON_SIZE_BIG, tagLabel.width + _RES.s_DOUBLE_MARGIN)
            height: tagItem.height
            color: Style.Background.Tag[tagItem.style]

            Label {
                id: tagLabel
                anchors.left: parent.left
                anchors.leftMargin: _RES.s_MARGIN
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: _RES.s_TEXT_SIZE_SMALL
                color: Style.Typography.Tag[tagItem.style]
            }
        }
    }
}
