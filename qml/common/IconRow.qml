import QtQuick 2.0
import QtQuick.Layouts 1.1

RowLayout {
    id: iconRow
    //Needed for QtCreator design mode
//    width: childrenRect.width
    height: _RES.s_OMNI_BAR_HEIGHT
    //-----------
    spacing: 0
    layoutDirection: Qt.RightToLeft

    property alias iconsListModel: iconRowRepeater.model

    signal iconClicked (int index, string name)

    Repeater{
        id: iconRowRepeater
        Button
        {
            id: iconRowButton
            width: _RES.scale(96)
            Layout.fillHeight: true
            onClicked: iconRow.iconClicked(index, name)
            style: buttonStyle || "DEFAULT"
            Icon
            {
                id: iconRowIcon;
                name: icon
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
