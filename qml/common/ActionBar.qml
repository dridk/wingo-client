import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style

Rectangle {
    id: actionBar
    //Needed for QtCreator design mode
    width: 540
    height: 96
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property string style: Style.PAGE_DEFAULT

    color: Style.Background.Actionbar[actionBar.style]

    property alias icon : actionBarIcon.name
    property alias title: actionBarTite.text
    property alias actions: iconRow.iconsListModel

    property string actionType: Style.ACTION_BAR_MENU_ACTION

    signal clicked()
    signal actionClicked(int index, string name)


    RowLayout{
        id: actionBarRowLayout
        //        anchors.rightMargin: 16
        anchors.fill: parent
        spacing: 8

        RowLayout {

            RowLayout {
                id: mainIcon
                anchors.left: parent.left
                spacing: 0
                Icon{

                    name: actionBar.actionType + "48"
                }
                Icon{
                    id: actionBarIcon
                    name: "wingo48"
                    //We will need this in the future
                    //color: Style.Typography.Actionbar[style]
                }

               SelectArea {
                   anchors.fill: parent
               }


            }



            //            ActionItem{
            //                id: actionBarAction
            //                name: actionBar.actionType + "48"
            //                Layout.fillHeight: true
            //                onClicked: actionBar.clicked()
            //                //We will need this in the future
            //                //color: Style.Typography.Actionbar[style]
            //                Behavior on x {
            //                    NumberAnimation {
            //                        duration : 100
            //                    }
            //                }
            //            }

            //            Icon{
            //                id: actionBarIcon
            //                name: "wingo48"
            //                //We will need this in the future
            //                //color: Style.Typography.Actionbar[style]
            //            }

            Label{
                id: actionBarTite
                text: "Action Bar"
                anchors.verticalCenter: parent.verticalCenter
                color: Style.Typography.Actionbar[actionBar.style]
                Layout.fillWidth: true
            }

            ActionsRow{
                id: iconRow
                Layout.fillHeight: true
                onIconClicked: actionBar.actionClicked(index, name)
            }


        }

        states: [
            State {
                name: "MENU"

                when: menuOpen

                PropertyChanges {
                    target: iconRow
                    enabled: false
                    opacity: 0.8
                }

                PropertyChanges {
                    target: actionBarAction
                    x:-10
                }
            }
        ]
    }
}
