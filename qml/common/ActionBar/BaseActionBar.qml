import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../../scripts/AppStyle.js" as Style

Rectangle {
    id: actionBar
    default property alias _contentChildren: actionBarRowLayout.data

    //Needed for QtCreator design mode
    width: 540
    height: 96
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top

    property string style: Style.PAGE_DEFAULT

    color: Style.Background.Actionbar[actionBar.style]

    RowLayout{
        id: actionBarRowLayout
        anchors.fill: parent
        spacing: 8

    }
    states: [
        State {
            name: "DISABLED"

            PropertyChanges {
                target: actionBar
                enabled: false
            }
        }
    ]
}
