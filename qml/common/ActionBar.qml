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
    anchors.top: parent.top

    property string style: Style.ACTION_BAR_DEFAULT

    color: Style.Background.Actionbar[actionBar.style]

    property alias icon: actionBarIcon.name
    property alias title: actionBarTite.text
    property alias actionsListModel: iconRow.iconsListModel

    property string actionType: Style.ACTION_BAR_MENU_ACTION

    signal menuButtonClicked
    signal backButtonClicked
    signal toolbarButtonClicked (int index, string name)

    RowLayout{
//        anchors.rightMargin: 16
        anchors.fill: parent
        spacing: 8
        Button {
            id: actionButton
            width: childrenRect.width
            Layout.fillHeight: true
            onClicked: {
                if (actionBar.actionType === Style.ACTION_BAR_MENU_ACTION) menuButtonClicked();
                else backButtonClicked();
            }

            RowLayout{
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8
                Icon{
                    id: actionBarAction
                    name: actionBar.actionType + "48"
                    //We will need this in the future
                    //color: Style.Typography.Actionbar[style]
                }
                Icon{
                    id: actionBarIcon
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
            Layout.fillWidth: true
            //We will need this in the future
//            color: Style.Typography.Actionbar[style]
            onIconClicked: actionBar.toolbarButtonClicked(index, name)
        }
    }
}
