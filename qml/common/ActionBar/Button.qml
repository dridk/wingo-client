import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../scripts/AppStyle.js" as Style
import "../Components" as Componenets
import "../Controls" as Widgets

Componenets.TouchSensorArea {
    id: button
    //Needed for QtCreator design mode
//    height: 64
    //-----------
    height: _RES.s_ACTION_BAR_HEIGHT
    width: height
    Layout.fillHeight: true
    preventStealing: true

    opacity: enabled? 1 : 0.8

    property string style: "DEFAULT"
    property alias icon: buttonIcon.name

    Widgets.Icon {
        id: buttonIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: Style.Icon.Actionbar[button.style]
        size: _RES.s_ACTION_BAR_BUTTON_SIZE
    }
}
