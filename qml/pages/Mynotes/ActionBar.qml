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
    enabled: !omniBar.expanded
    style: "ALTERNATIVE"
    ActionBar.Title {
        style: actionBar.style
        icon: Icons.CARRET_LEFT
        text: "My Notes"
        onClicked: page.back()
    }
    ActionBar.Right{
        ActionBar.Button{
            icon: Icons.CHECKMAK_FULL
        }
        ActionBar.Button{
            icon: Icons.ARCHIVE
        }
    }
}
