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
                onClicked: app.goBack()
            }
            ActionBar.Right{
                ActionBar.Action {
                    icon: Icons.LOGO
                    onClicked: {
                        var email = "sacha@labsquare.org"
                        var pass = "sacha"
                        console.debug("login")
                        loginRequester.post({"email":email, "password":pass})


                    }
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

    Request {
        id: loginRequester
        source: "/users/login"

        onSuccess: {
            app.requestCurrentUser()
        }


    }
}
