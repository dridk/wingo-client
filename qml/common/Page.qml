import QtQuick 2.0

import "../scripts/AppStyle.js" as Style

Rectangle
{
    id: page
    default property alias _contentChildren: content.data

    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------

    color: Style.Background.WINDOW

    property alias icon: actionBar.icon
    property alias title: actionBar.title
    property alias style: actionBar.style

    property alias defaultAction: actionBar.actionType
    property alias actionsListModel: actionBar.actionsListModel

    property int backgroundAnimationDuration: 500

    property alias footer: _footer.source

    signal menuButtonClicked
    signal backButtonClicked
    signal actionButtonClicked (int index, string name)

    //Main Page structure
    ActionBar
    {
        //The top most element of every page - action bar
        id: actionBar
        onMenuButtonClicked: page.menuButtonClicked()
        onBackButtonClicked: page.backButtonClicked()
        onToolbarButtonClicked: page.actionButtonClicked(index, name)
    }

    Item
    {
        //Page content
        id: content
        anchors.bottom: _footer.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: actionBar.bottom
    }

    Loader
    {
        //Placeholder for the footer element
        //Not every page has it
        id: _footer
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    //Page shadowing effect
    Rectangle
    {
        id: overlay
        color: Style.Background.OVERLAY
        anchors.fill: parent
        opacity: 0
        Behavior on opacity {NumberAnimation{duration: page.backgroundAnimationDuration}}
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
