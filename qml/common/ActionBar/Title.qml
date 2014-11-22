import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../Components" as Components
import "../Controls" as Widgets

Components.TouchSensorArea {
    id: actionBarTitle
    width: actionBarTitleRow.width
    //Needed for QtCreator design mode
    height: 64
    //-----------
    Layout.fillHeight: true
    preventStealing: true

    property string style: "DEFAULT"
    property alias icon: actionBarAction.name
    property alias text: actionBarTite.text

    opacity: enabled? 1 : 0.8

    Row{
        id: actionBarTitleRow
        width: Math.min(childrenRect.width, app.width * 0.5)
        height: parent.height
        spacing: _RES.s_MARGIN
        Widgets.Icon{
            id: actionBarAction
            name: Icons.CARRET_LEFT
            anchors.verticalCenter: parent.verticalCenter
            color: Style.Icon.Actionbar[actionBarTitle.style]
        }
        Widgets.Label{
            id: actionBarTite
            text: "Action Bar"
            anchors.verticalCenter: parent.verticalCenter
            color: Style.Typography.Actionbar[actionBarTitle.style]

        }
        Item{
            width: _RES.s_MARGIN
            height: parent.height
        }
    }
}
