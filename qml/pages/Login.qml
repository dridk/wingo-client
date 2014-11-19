import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar


Layouts.Page {
    id: page



    Item{
        anchors.fill: parent
        ActionBar.Widget {
            id: actionBar
            ActionBar.Title {
                icon: Icons.CARRET_LEFT
                text: "Login"
                onClicked: page.back()
            }
            ActionBar.Right{
                ActionBar.Action {
                    icon: Icons.LOGO
                    onClicked: page.post()
                }
            }
        }


        Column {
            width: parent.width
            anchors.top: actionBar.bottom
            Widgets.EntryBox {
                placeholder: "Username"
            }

            Widgets.EntryBox {
                placeholder: "Password"
            }


        }





    }
}
