import QtQuick 2.0
import Wingo 1.0
//import QtGraphicalEffects 1.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../Components"

//CalloutRectangle {
Item{
    id: avatar
    width: _RES.s_ICON_SIZE_BIG
    height: width

//    color: Style.Background.VIEW
//    tipSize: 10

    property alias source: avatarImage.source

//    Icon{
//        id: avatarPlaceholder
//        anchors.centerIn: parent
//        name: Icons.LOGO
//        visible: avatarImage.status == MaskImage.Ready
//    }

    MaskImage {
        id: avatarImage
        anchors.fill: parent
        anchors.margins: _RES.s_HALF_MARGIN
        mask : "qrc:/qml/Res/images/mask.png"

        sourceMode : MaskImage.CompositionMode_SourceOut
        destinationMode: MaskImage.CompositionMode_DestinationOut
//        visible: status === MaskImage.Ready
    }


}
