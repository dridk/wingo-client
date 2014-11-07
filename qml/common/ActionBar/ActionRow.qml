import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../"

RowLayout {
    id: iconRow
    //Needed for QtCreator design mode
    height: 96
    //-----------
    spacing: 0
    Layout.fillWidth: true
    Layout.fillHeight: true
    layoutDirection: Qt.RightToLeft

    property string style: "DEFAULT"
    property alias actionListModel: iconRowRepeater.model

    signal iconClicked (int index, string name)

    Repeater{
        id: iconRowRepeater
        Button
        {
            id: iconRowButton
            width: iconRowIcon.width + 24
            Layout.fillHeight: true
            onClicked: iconRow.iconClicked(index, name)
            Icon
            {
                id: iconRowIcon
                name: icon
                //We will need this in the future
                //color: Style.Typography.Actionbar[iconRow.style]
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
