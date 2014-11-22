import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../../common/ActionBar" as ActionBar
import "../../common/Controls" as Widgets

ActionBar.Widget {
    id: actionBar
    ActionBar.Title {
        icon: Icons.SANDWICH
        text: "80 Inverlochy Blvd<br><small>Toronto, ON</small>"
        onClicked: page.menu()
    }
    ActionBar.Right{
        ActionBar.Button{
            icon: Icons.POCKET
            onClicked: page.goPocket()
            Widgets.Badge{
                value: app.logged ? app.currentUser["pocket_count"] : 0
                style: "ACTIONBAR"
                anchors.right: parent.right
                anchors.rightMargin: _RES.s_MARGIN
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        ActionBar.Button{
            icon: Icons.REFRESH
            onClicked: page.refresh()
        }
    }
}
