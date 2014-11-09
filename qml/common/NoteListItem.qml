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
    height: Math.max(96, message.length / 18 * 16 + 48)
    color: Style.Background.VIEW

    ColumnLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.right: parent.right
        anchors.rightMargin: 8
        spacing: 0

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 8
            Label{
                text: anonymous? qsTr("Anonimous") : author.nickname
                font.pointSize: 12; color: Style.Typography.LINK; Layout.fillWidth: false
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
                font.pointSize: 12; color: Style.Typography.QUOTE; Layout.fillWidth: false
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
                font.pointSize: 12; color: Style.Typography.QUOTE; Layout.fillWidth: true
            }
            Label{
                visible:expiration!=="None"
                text: "30d left"
                horizontalAlignment: Text.AlignRight
                font.pointSize: 12; color: Style.Typography.LINK ;Layout.fillWidth: false
            }
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 8
            Label{
                text: StringFormat.setWordColor(message, Style.Typography.LINK ,/\#\w+/g)
                Layout.fillWidth: true
                Layout.fillHeight: true
                wrapMode: Text.WordWrap
            }
            Item{
                id: item1
                width: 64
                Layout.fillWidth: false
                Layout.fillHeight: true
                Label {
                    text: qsTr("%1<br>takes").arg(takes)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignRight; font.pointSize: 12; color: Style.Typography.ACCENT
                }
            }
        }

    }

//    RowLayout{
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 8
//        anchors.top: parent.top
//        anchors.topMargin: 8
//        anchors.left: parent.left
//        anchors.leftMargin: 32
//        anchors.right: parent.right
//        anchors.rightMargin: 8
//        spacing: 8

//        ColumnLayout{
//            Layout.fillWidth: true

//            Label{
//                text: qsTr("%1 %2, %3").arg(anonymous? qsTr("Anonimous") : author.nickname).arg(
//                          DateFormat.toNow(timestamp , [
//                                               qsTr("just now"),
//                                               qsTr("min ago"),
//                                               qsTr("h ago"),
//                                               qsTr("mon ago"),
//                                               qsTr("days ago"),
//                                               qsTr("yr ago")
//                                           ])
//                          ).arg (
//                            DistanceFormat.toHere(
//                              DistanceFormat.pointObject(app.latitude, app.longitude),
//                              DistanceFormat.pointObject(lat, lon),
//                              [
//                                  qsTr("right here"),
//                                  qsTr("m away"),
//                                  qsTr("km away"),
//                                  qsTr("very far...")
//                              ]
//                              )
//                          )
//                font.pointSize: 12; color: Style.Typography.QUOTE; Layout.fillWidth: true}
//            Label{
//                text: StringFormat.setWordColor(message, Style.Typography.LINK ,/\#\w+/g)
//                Layout.fillWidth: true
//                Layout.fillHeight: true
//                wrapMode: Text.WordWrap
//            }
//        }
//        ColumnLayout{
//            width: 64
//            Label{visible:expiration!=="None";text: "30d left"; horizontalAlignment: Text.AlignRight; font.pointSize: 12; color: Style.Typography.LINK ;Layout.fillWidth: true}
//            Label{text: qsTr("%1<br>takes").arg(takes); horizontalAlignment: Text.AlignRight; font.pointSize: 12; color: Style.Typography.ACCENT ;Layout.fillWidth: true}
//        }
//    }

    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
