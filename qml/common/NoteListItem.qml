import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style

Rectangle{
    anchors.left: parent.left
    anchors.right: parent.right
    height: Math.max(96, message.length / 18 * 16 + 48)
    color: Style.Background.VIEW


    function parseTags(text){

         return text.replace(/#\w+/g, "<b>$& </b>")
    }

    RowLayout{
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.right: parent.right
        anchors.rightMargin: 8
        spacing: 8

        ColumnLayout{
            Layout.fillWidth: true
            Label{text: (anonymous? "Anonimous" : author.nickname) + " 1h"; font.pointSize: 12; color: Style.Typography.LINK; Layout.fillWidth: true}
            Label{
                text: parseTags(message)
                Layout.fillWidth: true
                Layout.fillHeight: true
                wrapMode: Text.WordWrap





            }
        }
        ColumnLayout{
            width: 64
            Label{text: "30d left"; horizontalAlignment: Text.AlignRight; font.pointSize: 12; color: Style.Typography.LINK ;Layout.fillWidth: true}
            Label{text: "12 takes"; horizontalAlignment: Text.AlignRight; font.pointSize: 12; color: Style.Typography.ACCENT ;Layout.fillWidth: true}
        }
    }

    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
