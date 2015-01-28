import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../../common/ActionBar" as ActionBar
import "../../common/Controls" as Widgets

ActionBar.Widget {
    id: actionBar
    z: omniBar.expanded? 0: 4 //We need this to make sure omniBar tray closes when clicked outside
    hasShadow: omniBar.hidden
//    enabled: !omniBar.expanded
    property alias title : titleId.text
    signal menuClicked()
    signal refreshClicked()

    ActionBar.Title {
        id:titleId
        icon: Icons.SANDWICH
        text: app.positionTitle
        onClicked: menuClicked()
    }
    ActionBar.Right{
        ActionBar.Button{
            icon: Icons.POCKET
            onClicked: page.goPocket()
            visible: app.logged
            Widgets.Badge{
                value: app.logged ? app.pocket_count : 0
                style: "ACTIONBAR"
                anchors.right: parent.right
                anchors.rightMargin: _RES.s_MARGIN
                anchors.verticalCenter: parent.verticalCenter

            }
        }
        ActionBar.Button{
            icon: Icons.REFRESH
            onClicked: refreshClicked()
        }
    }

}
