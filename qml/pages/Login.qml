import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar


Layouts.Page {
    id: page
//    color: Style.Palette.CYAN


    Request {
        id: loginRequester
        source: "/users/login"

        onSuccess: {
            app.requestCurrentUser()
            app.goBack()
        }

        onError: {
            app.showMessage("Alert", "Bad login or password")
        }


    }

    ActionBar.Widget {
        id: actionBar
        ActionBar.Title {
            icon: Icons.CARRET_LEFT
            text: "Login"
            onClicked: page.back()
        }
    }

    Rectangle{
        anchors.centerIn: parent
        anchors.verticalCenterOffset: - _RES.s_TRIPPLE_MARGIN
        width: parent.width * 0.85
        height: childrenRect.height + _RES.s_TRIPPLE_MARGIN
        radius: _RES.s_MARGIN
        color: Style.Background.VIEW

        Column {
            spacing: _RES.s_MARGIN
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: _RES.s_DOUBLE_MARGIN

            Widgets.EntryBox {
                id:emailBox
                placeholder: "Email"
                text:"sacha@labsquare.org"
                inputMethodHints: Qt.ImhEmailCharactersOnly
                anchors.left: parent.left
                anchors.right: parent.right
            }

            Widgets.EntryBox {
                id:passBox
                placeholder: "Password"
                text:"sacha"
                inputMethodHints: Qt.ImhHiddenText
                anchors.left: parent.left
                anchors.right: parent.right
            }

            Widgets.Button {
                anchors.horizontalCenter: parent.horizontalCenter
                icon: Icons.LOGO
                text: qsTr("Login...")
                style: "ACTION"
                onClicked: {
                    var email = emailBox.text
                    var pass = passBox.text
                    console.debug("login")
                    loginRequester.post({"email":email, "password":pass})
                }
            }

        }
    }

//    Item{
//        anchors.fill: parent
//        ActionBar.Widget {
//            id: actionBar
//            ActionBar.Title {
//                icon: Icons.CARRET_LEFT
//                text: "Login"
//                onClicked: app.goBack()
//            }
//            ActionBar.Right{
//                ActionBar.Action {
//                    icon: Icons.LOGO
//                    onClicked: {
//                        var email = emailBox.text
//                        var pass = passBox.text
//                        console.debug("login")
//                        loginRequester.post({"email":email, "password":pass})


//                    }
//                }
//            }
//        }


//        Column {
//            width: parent.width
//            anchors.top: actionBar.bottom
//            Widgets.EntryBox {
//                id:emailBox
//                placeholder: "Email"
//                text:"sacha@labsquare.org"
//                inputMethodHints: Qt.ImhEmailCharactersOnly

//            }

//            Widgets.EntryBox {
//                id:passBox
//                placeholder: "Password"
//                text:"sacha"
//                inputMethodHints: Qt.ImhHiddenText
//            }


//        }

//    }

}
