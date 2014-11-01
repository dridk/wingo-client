import QtQuick 2.0

Item
{
    id: page
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------
    anchors.fill: parent

    property string icon: ""
    property string title: ""

    ActionBar
    {
        id: actionBar
    }

    Item
    {
        id: content
    }

    Item
    {
        id: footer
    }
}
