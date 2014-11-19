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
                text: "Account"
                onClicked: app.goBack()
            }
            ActionBar.Right{
                ActionBar.Action {
                    icon: Icons.INFO
                    onClicked: logoutRequester.deleteResource()


                }
            }
        }


        Widgets.Label {
            anchors.centerIn: parent
            text: app.logged ? app.currentUser["email"] : ""
        }





    }


    Request {
        id:logoutRequester
        source:"/users/logout"
        onSuccess: {
            app.goBack()
            app.logged = false
            app.currentUser = 0
        }

    }




}
