import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar


Layouts.Page {
    id: page

    ActionBar.Widget {
        id: actionBar
        style: Style.PAGE_UTILITY
        ActionBar.Title {
            icon: Icons.CARRET_LEFT
            text: "About"
            onClicked: page.back()
        }
    }

    Flickable{
        id: aboutListView
        anchors.top: actionBar.bottom
    }

}
