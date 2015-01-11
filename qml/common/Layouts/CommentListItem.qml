import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../../scripts/DateFormat.js" as DateFormat
import "../../scripts/StringFormat.js" as StringFormat
import "../../scripts/DistanceFormat.js" as DistanceFormat

import "../Components" as Componenets
import "../Controls" as Widgets

Item {
    anchors.left: parent.left
    anchors.right: parent.right
    height: commentBody.height

    Widgets.Avatar{
        id: commentAvatar
        source: $author && $author.hasOwnProperty(
                    'avatar') ? $author.avatar : "qrc:/qml/Res/images/anonymous.png"
        anchors.bottom: parent.commentBody
        anchors.bottomMargin: _RES.s_MARGIN
        anchors.right: parent.right
    }

    Componenets.CalloutRectangle {
        id: commentBody
        anchors.left: parent.left
        anchors.right: commentAvatar.left
        anchors.margins: _RES.s_MARGIN

        height: commentColumn.height + _RES.s_TRIPPLE_MARGIN

        tipVerticalAlignment: Style.CALLOUT_TOP
        tipHorizontalAlignment: Style.CALLOUT_RIGHT_DOMINANAT
        tipMargin: _RES.s_DOUBLE_MARGIN

        Column {
            id: commentColumn
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: _RES.s_DOUBLE_MARGIN
            spacing: _RES.s_MARGIN

            Widgets.Label{
                text: StringFormat.setWordColor($message,
                                                Style.Typography.LINK, /\#\w+/g)
                anchors.left: parent.left
                anchors.right: parent.right
                wrapMode: Text.WordWrap
            }

            Row{
                anchors.right: parent.right
                spacing: _RES.s_MARGIN

                Widgets.Label {
                    //Post date
                    text: DateFormat.toNow($timestamp,
                                           [qsTr("just now"), qsTr(
                                                "min ago"), qsTr("h ago"), qsTr(
                                                "days ago"), qsTr(
                                                "mon ago"), qsTr("yr ago")])
                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.QUOTE
                }

                Widgets.Label {
                    //User name
                    text: qsTr("by ") + $author.nickname
                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.LINK
                }
            }
        }

        Image{
            height: _RES.scale(4)
            source: "../../Res/images/shadow.png"
            anchors.top: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
}
