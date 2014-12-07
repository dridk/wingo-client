import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../../common/ActionBar" as ActionBar
import "../../common/Controls" as Widgets

ActionBar.Widget {
    id: actionBar
    z: omniBar.expanded? 1: 4 //We need this to make sure omniBar tray closes when clicked outside
    enabled: !omniBar.expanded
    hasShadow: false

    ActionBar.Title {
        icon: Icons.CARRET_LEFT
        text: app.positionTitle
        onClicked: page.back()
    }
    ActionBar.Right{
        ActionBar.Button {
            icon: Icons.LOCATION
            onClicked: {}
        }

        ActionBar.Action {
            icon: Icons.LOGO
            onClicked: page.post()
        }
    }
}
