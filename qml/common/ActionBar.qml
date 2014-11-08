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


    RowLayout {
        id:mainLayout
        anchors.fill: parent
        RowLayout {
            id: mainIconLayout
            anchors.left: parent.left
            spacing: 0
            Icon{
                name: actionBar.actionType + "48"
                Layout.fillHeight: true
            }
            Icon{
                id: actionBarIcon
                name: "wingo48"

                //We will need this in the future
                //color: Style.Typography.Actionbar[style]
            }

            SelectArea {
                anchors.fill: parent
                onClicked: actionBar.clicked()
            }
        }

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
