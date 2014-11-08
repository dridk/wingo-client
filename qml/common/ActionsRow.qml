import QtQuick 2.0
import QtQuick.Layouts 1.1

RowLayout {
    id: iconRow
    //Needed for QtCreator design mode
    //    width: childrenRect.width
    height: 96
    //-----------
    spacing: 10
    layoutDirection: Qt.RightToLeft

    property alias iconsListModel: iconRowRepeater.model

    signal iconClicked (int index, string name)

    Repeater{
        id: iconRowRepeater

        ActionItem {
            id: iconRowIcon;
            name: icon
            Layout.fillHeight: true


        }
    }

}
