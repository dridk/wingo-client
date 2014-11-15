import QtQuick 2.0
import Wingo 1.0
//import QtGraphicalEffects 1.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../Components"

CalloutRectangle {
    id: avatar
    width: _RES.s_ICON_SIZE_BIG
    height: width

    color: Style.Background.WINDOW
    tipSize: 10

    property alias source: avatarImage.source

    Icon{
        id: avatarPlaceholder
        anchors.centerIn: parent
        name: Icons.LOGO
        visible: !avatarImage.visible
    }

    Image {
        id: avatarImage
        anchors.fill: parent
        anchors.margins: _RES.s_HALF_MARGIN
        visible: status === Image.Ready
    }


}
