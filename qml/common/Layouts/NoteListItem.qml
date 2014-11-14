import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../scripts/AppStyle.js" as Style
import "../../scripts/DateFormat.js" as DateFormat
import "../../scripts/StringFormat.js" as StringFormat
import "../../scripts/DistanceFormat.js" as DistanceFormat

import "../Components" as Componenets
import "../Controls" as Widgets

Componenets.WidgetItemBase{
    id: noteListItem
    //Needed for QtCreator design mode
    width: 540
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    height: Math.max(_RES.s_NOTE_LIST_MIN_HEIGHT, noteLayout.height)
    outerShadow: false

    Column {
        id: noteLayout
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

            Widgets.Label{
                text: anonymous? qsTr("Anonimous") : author.nickname
                font.pixelSize: _RES.s_TEXT_SIZE_SMALL ; color: Style.Typography.LINK; Layout.fillWidth: false
            }
            Widgets.Label{
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
            Widgets.Label{
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
            Widgets.Label{
//                visible:expiration!=="None"
                text: "30d left"
                horizontalAlignment: Text.AlignRight
                font.pixelSize: _RES.s_TEXT_SIZE_SMALL; color: Style.Typography.LINK ;Layout.fillWidth: false
            }
        }

        RowLayout{
            anchors.right: parent.right
            anchors.left: parent.left
            spacing: _RES.s_BASE_UNIT

            Widgets.Label{
                text: StringFormat.setWordColor(message, Style.Typography.LINK ,/\#\w+/g)
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
            }
            Item{
                width: _RES.scale(64)
                Layout.fillWidth: false
                Layout.fillHeight: true
                ColumnLayout{
                    Image {
                        width: _RES.scale(64)
                        height: width
//                        color: "silver"
                        source: status == Image.Ready ? author.avatar :"qrc:/qml/Res/images/anonymous.png"
                    }

                    Widgets.Label {
                        text: qsTr("%1<br>takes").arg(takes)
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignRight; font.pixelSize: _RES.s_TEXT_SIZE_SMALL; color: Style.Typography.ACCENT
                    }
                }
            }
        }

        Item {
            anchors.right: parent.right
            anchors.left: parent.left
            height: _RES.s_TRIPPLE_MARGIN
        }

    }

}
