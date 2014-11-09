import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style
import "../scripts/DateFormat.js" as DateFormat
import "../scripts/StringFormat.js" as StringFormat
import "../scripts/DistanceFormat.js" as DistanceFormat

Rectangle{
    //Needed for QtCreator design mode
    width: 540
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    height: Math.max(_RES.s_NOTE_LIST_MIN_HEIGHT, column1.height) //message.length / 18 * 16 + 48)
    color: Style.Background.VIEW

    Column {
        id: column1
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: _RES.s_MARGIN
        anchors.top: parent.top
        anchors.topMargin: _RES.s_DOUBLE_MARGIN
        anchors.left: parent.left
        anchors.leftMargin: _RES.s_TRIPPLE_MARGIN
        anchors.right: parent.right
        anchors.rightMargin: _RES.s_MARGIN
        spacing: _RES.s_BASE_UNIT

        RowLayout{
            anchors.right: parent.right
            anchors.left: parent.left
            spacing: _RES.s_BASE_UNIT

            Label{
                text: anonymous? qsTr("Anonimous") : author.nickname
                font.pixelSize: _RES.s_TEXT_SIZE_SMALL ; color: Style.Typography.LINK; Layout.fillWidth: false
            }
            Label{
                text: DateFormat.toNow(timestamp , [
                                               qsTr("just now"),
                                               qsTr("min ago"),
                                               qsTr("h ago"),
                                               qsTr("mon ago"),
                                               qsTr("days ago"),
                                               qsTr("yr ago")
                                           ])
                font.pixelSize: _RES.s_TEXT_SIZE_SMALL; color: Style.Typography.QUOTE; Layout.fillWidth: false
            }
            Label{
                text: DistanceFormat.toHere(
                              DistanceFormat.pointObject(app.latitude, app.longitude),
                              DistanceFormat.pointObject(lat, lon),
                              [
                                  qsTr("right here"),
                                  qsTr("m away"),
                                  qsTr("km away"),
                                  qsTr("very far...")
                              ]
                              )
                font.pixelSize: _RES.s_TEXT_SIZE_SMALL; color: Style.Typography.QUOTE; Layout.fillWidth: true
            }
            Label{
                visible:expiration!=="None"
                text: "30d left"
                horizontalAlignment: Text.AlignRight
                font.pixelSize: _RES.s_TEXT_SIZE_SMALL; color: Style.Typography.LINK ;Layout.fillWidth: false
            }
        }

        RowLayout{
            anchors.right: parent.right
            anchors.left: parent.left
            spacing: _RES.s_BASE_UNIT

            Label{
                text: StringFormat.setWordColor(message, Style.Typography.LINK ,/\#\w+/g)
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
            }
            Item{
                id: item1
                width: _RES.scale(64)
                Layout.fillWidth: false
                Label {
                    text: qsTr("%1<br>takes").arg(takes)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignRight; font.pixelSize: _RES.s_TEXT_SIZE_SMALL; color: Style.Typography.ACCENT
                }
            }
        }

        Item {
            anchors.right: parent.right
            anchors.left: parent.left
            height: _RES.s_DOUBLE_MARGIN
        }

    }

    Rectangle{
        height: _RES.s_BORDER
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
