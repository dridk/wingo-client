import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../scripts/AppStyle.js" as Style
import "../../scripts/Icons.js" as Icon
import "../../scripts/Utilities.js" as Utilities
import "../Components" as Components
import "../Controls" as Widgets

Components.WidgetItemBase  {
    id: switchBar
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_OMNI_BAR_HEIGHT

    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    Row {
        anchors.fill: parent
        Button {
            text: "Small"
        }
        Button {
            text: "Medium"
        }
        Button {
            text: "Large"
        }

    }
}
