import QtQuick 2.0

import "../scripts/AppStyle.js" as Style

Rectangle
{
    id: page
    width: 540
    height: 960
    //-----------
    color: Style.Background.WINDOW


    //Page shadowing effect
    Rectangle
    {
        id: overlay
        color: Style.Background.OVERLAY
        anchors.fill: parent
        opacity: 0
        Behavior on opacity {NumberAnimation{duration: 500}}
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
