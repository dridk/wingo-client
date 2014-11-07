import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../../scripts/AppStyle.js" as Style
import ".."

Button {
    id: actionButton
    width: childrenRect.width
    //Needed for QtCreator design mode
    height: 64
    //-----------
    Layout.fillHeight: true

    property alias actionType: actionBarAction.name
    property alias icon: actionBarIcon.name
    property alias title: actionBarTite.text

    RowLayout{
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8
        Icon{
            id: actionBarAction
            name: actionButton.actionType + "48"
            //We will need this in the future
            //color: Style.Typography.Actionbar[actionButton.style]
            Behavior on x {
                NumberAnimation {
                    duration : 100
                }
            }
        }
        Icon{
            id: actionBarIcon
            name: "wingo48"
            //We will need this in the future
            //color: Style.Typography.Actionbar[actionButton.style]
        }
        Label{
            id: actionBarTite
            text: "Action Bar"
            anchors.verticalCenter: parent.verticalCenter
            color: Style.Typography.Actionbar[actionButton.style]
            Layout.fillWidth: true
        }
    }
}
