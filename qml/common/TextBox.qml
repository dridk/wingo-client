import QtQuick 2.0

import "../scripts/AppStyle.js" as Style

Item {
    id: textBox
    //Needed for QtCreator design mode
    width: 540
    height: 48
    //-----------

    property alias text: textBoxEdit.text
    property alias placeholder: textBoxPlaceholder.text

    Rectangle{
        height: 16

        color: Style.Background.WINDOW
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    Rectangle{

        color: Style.Background.VIEW
        anchors.rightMargin: 4
        anchors.leftMargin: 4
        anchors.bottomMargin: 3
        anchors.topMargin: 2
        anchors.fill: parent

        TextEdit{
            id: textBoxEdit
            font.pointSize: 16
            textFormat: Text.PlainText
            font.family: "Droid Sans"
            color: Style.Typography.TEXT
            anchors.bottomMargin: 4
            anchors.rightMargin: 8
            anchors.leftMargin: 8
            anchors.fill: parent
            focus: textBox.focus

            Label{
                id: textBoxPlaceholder
                text: "Placeholder..."
                anchors.fill: parent
                color: Style.Typography.FADE
                visible: !parent.text
            }

        }
    }

}
