import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../Components" as Components
import "../../scripts/AppStyle.js" as Style

Components.WidgetItemBase {
    id: actionBar
    default property alias _contentChildren: actionBarRowLayout.data

    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_ACTION_BAR_HEIGHT
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top

    z: 99 //Always on top of page layout

    property string style: parent.style || Style.PAGE_DEFAULT

    color: Style.Background.Actionbar[actionBar.style]

    RowLayout{
        id: actionBarRowLayout
        anchors.fill: parent
        spacing: _RES.s_MARGIN
        opacity: parent.enabled? 1: 0.8
        Behavior on opacity {NumberAnimation{duration: 100}}
    }
}
