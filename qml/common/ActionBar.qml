import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style

Rectangle {
    id: actionBar
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_ACTION_BAR_HEIGHT
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top

    property string style: Style.PAGE_DEFAULT

    color: Style.Background.Actionbar[actionBar.style]

    property alias icon: actionBarIcon.name
    property alias title: actionBarTite.text
    property alias actionsListModel: iconRow.iconsListModel

    property string actionType: Style.ACTION_BAR_MENU_ACTION

    signal menuButtonClicked
    signal backButtonClicked
    signal toolbarButtonClicked (int index, string name)

    property bool menuOpen: false

    RowLayout{
        id: actionBarRowLayout
//        anchors.rightMargin: 16
        anchors.fill: parent
        spacing: _RES.s_MARGIN
        Button {
            id: actionButton
            width: childrenRect.width
            Layout.fillHeight: true
            onClicked: {
                if (actionBar.actionType === Style.ACTION_BAR_MENU_ACTION){
                    //Toggle menu state
                    //This is very-very UGLY@!!!!
                    menuOpen = !menuOpen;
                    menuButtonClicked();
                }
                else backButtonClicked();
            }

            RowLayout{
                anchors.verticalCenter: parent.verticalCenter
                spacing: _RES.s_MARGIN
                Icon{
                    id: actionBarAction
                    width: _RES.scale(48)
                    height: width
                    name: actionBar.actionType + "48"
                    //We will need this in the future
                    //color: Style.Typography.Actionbar[style]
                    Behavior on x {
                        NumberAnimation {
                            duration : 100
                        }
                    }
                }
                Icon{
                    id: actionBarIcon
                    width: _RES.scale(48)
                    height: width
                    name: "wingo48"
                    //We will need this in the future
                    //color: Style.Typography.Actionbar[style]
                }
            }
        }
        Label{
            id: actionBarTite
            text: "Action Bar"
            anchors.verticalCenter: parent.verticalCenter
            color: Style.Typography.Actionbar[actionBar.style]
            Layout.fillWidth: true
        }
        IconRow{
            id: iconRow
            Layout.fillHeight: true
            //We will need this in the future
//            color: Style.Typography.Actionbar[style]
            onIconClicked: actionBar.toolbarButtonClicked(index, name)
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
                x:-_RES.s_BASE_UNIT
            }
        }
    ]
}
