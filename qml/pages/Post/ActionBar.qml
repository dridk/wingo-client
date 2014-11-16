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
        icon: Icons.CARRET_LEFT
        text: "80 Inverlochy Blvd<br><small>Toronto, ON</small>"
        onClicked: page.back()
    }
    ActionBar.Right{
        ActionBar.Action {
            icon: Icons.LOGO
            onClicked: page.post()
        }
    }
}
