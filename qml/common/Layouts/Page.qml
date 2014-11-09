import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style

Rectangle
{
    id: page
    default property alias _contentChildren: pageContent.data

    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------

    property string style: Style.PAGE_DEFAULT
    color: Style.Background.WINDOW

    property int backgroundAnimationDuration: 500

    property Component header: Item{}
    property Component footer: Item{}

    property alias pageInteractionTracking: pageClickSensor.enabled
    property alias containsMouse: pageClickSensor.containsMouse
    property alias pressed: pageClickSensor.pressed

    signal pageInteraction (variant mouse)

    //Main Page structure
    Loader
    {
        //Placeholder for the footer element
        //Not every page has it
        id: pageHeader
        sourceComponent: header
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Item
    {
        //Page content
        id: pageContent
        anchors.top: _header.bottom
        anchors.bottom: _footer.top
        anchors.right: parent.right
        anchors.left: parent.left
    }

    Loader
    {
        //Placeholder for the footer element
        //Not every page has it
        id: pageFooter
        sourceComponent: footer
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    //Page shadowing effect
    Rectangle
    {
        id: pageOverlay
        color: Style.Background.OVERLAY
        anchors.fill: parent
        opacity: 0
        Behavior on opacity {NumberAnimation{duration: page.backgroundAnimationDuration}}
    }

    //Page click sensor
    //Used to detect onClickOutside events
    MouseArea{
        id: pageClickSensor
        anchors.fill: parent
        propagateComposedEvents: true
        onClicked: pageInteraction (mouse)
    }

    states: [
        State {
            name: "DISABLED"
            when: !page.enabled
            PropertyChanges {
                target: overlay
                opacity: 1
            }
        }
    ]
}
