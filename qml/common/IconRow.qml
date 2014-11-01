import QtQuick 2.0
import QtQuick.Layouts 1.1

RowLayout {
    //Needed for QtCreator design mode
    width: 540
    height: 96
    //-----------

    property alias icons: repeater.model

    Repeater{
        id: repeater
        Button
        {

            onClick: onClick
            Icon
            {
                name: icon
            }
        }
    }
}
