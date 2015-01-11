import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtPositioning 5.2

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../../scripts/DateFormat.js" as DateFormat
import "../../scripts/StringFormat.js" as StringFormat
import "../../scripts/DistanceFormat.js" as DistanceFormat

import "../Components" as Componenets
import "../Controls" as Widgets

Componenets.TouchSensorArea {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    height: noteListItem.height + _RES.s_MARGIN


    property string lat
    property string lon
    property url picture
    property bool anonymous
    property string nickname
    property url avatar
    property string timestamp
    property alias takesCount: noteTakesBadge.value
    property string message

    property bool selectable: false
    property alias selected: itemSelected.checked

    function select(){
        itemSelected.checked = true
    }

    function deselect(){
        itemSelected.checked = false
    }

    function selectionToggle(){
        itemSelected.checked = !itemSelected.checked
    }

    Widgets.Checkmark {
        id: itemSelected
        anchors.left: parent.left
        anchors.leftMargin: _RES.s_MARGIN
        anchors.verticalCenter: parent.verticalCenter
        enabled: false
    }

    Componenets.WidgetItemBase {
        id: noteListItem
        anchors.top: parent.top
        x:0
        width: parent.width
//        anchors.left: parent.left
//        anchors.right: parent.right
        anchors.margins: _RES.s_MARGIN
        height: Math.max(_RES.s_NOTE_LIST_MIN_HEIGHT, noteLayout.height)
        property bool layoutMini: height === _RES.s_NOTE_LIST_MIN_HEIGHT

        Behavior on x { NumberAnimation{}}
        opacity: 1 - (x / width * 0.8)

        //    outerShadow: false
        Item {
            id: noteListItemDistance
            width: _RES.s_TRIPPLE_MARGIN
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            Widgets.Label {
                rotation: -90
                anchors.centerIn: parent
                    text: DistanceFormat.toHere(app.coordinate,
                                            QtPositioning.coordinate(lat, lon),
                                           [qsTr("here"), qsTr("m"), qsTr("km"), qsTr("far...")])
                font.pixelSize: _RES.s_TEXT_SIZE_MINI
                color: Style.Typography.FADE
                Layout.fillWidth: true
            }
        }

        Column {
            id: noteLayout
            //        anchors.bottom: parent.bottom
            //        anchors.bottomMargin: _RES.s_MARGIN
            anchors.top: parent.top
            anchors.topMargin: _RES.s_DOUBLE_MARGIN
            anchors.left: noteListItemDistance.right
            anchors.right: noteListItemAvatar.left
            anchors.rightMargin: _RES.s_MARGIN
            spacing: _RES.s_MARGIN

            Widgets.PictureFrame{
                source: picture != undefined ?picture : ""
            }

            Widgets.Label {
                text: StringFormat.setWordColor(message,
                                                Style.Typography.LINK, /\#\w+/g)
                anchors.right: parent.right
                anchors.left: parent.left
                wrapMode: Text.WordWrap
            }

            RowLayout {
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: _RES.s_MARGIN
                spacing: _RES.s_BASE_UNIT

                Widgets.Label {
                    //Expiery date
                    //                visible:expiration!=="None"
                    text: qsTr("expires in %1").arg(
                              DateFormat.toNow(new Date("12/12/2014"),
                                               [qsTr(""), qsTr("min"), qsTr(
                                                    "h"), qsTr("d"), qsTr(
                                                    "mo"), qsTr("yr")]))
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.QUOTE
                    Layout.fillWidth: true
                }

                Widgets.Label {
                    //User name
                    text: qsTr("posted")
                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.QUOTE
                    Layout.fillWidth: false
                }

                Widgets.Label {
                    //Post date
                    text: DateFormat.toNow(timestamp,
                                           [qsTr("just now"), qsTr(
                                                "min ago"), qsTr("h ago"), qsTr(
                                                "days ago"), qsTr(
                                                "mon ago"), qsTr("yr ago")])
                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.QUOTE
                    Layout.fillWidth: false
                }

                Widgets.Label {
                    //User name
                    text: qsTr("by")
                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.QUOTE
                    Layout.fillWidth: false
                }

                Widgets.Label {
                    //User name
                    text: anonymous ? qsTr("Anonimous") : nickname
                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.LINK
                    Layout.fillWidth: false
                }
            }

            Item {
                anchors.right: parent.right
                anchors.left: parent.left
                height: _RES.s_HALF_DOUBLE_MARGIN
            }



//            Image {
//                source: picture
//                width: parent.width
//                visible: picture == "null" ? false : true


//            }


        }

        Item {
            id: noteListItemAvatar
            width: _RES.s_ICON_SIZE_BIG
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            Widgets.Avatar {
                id: noteAvatar
                source: avatar == undefined || avatar=="" ?"qrc:/qml/Res/images/anonymous.png" : avatar
                anchors.top: parent.top
                anchors.topMargin: noteListItem.layoutMini ? _RES.s_HALF_MARGIN : _RES.s_DOUBLE_MARGIN
                anchors.right: parent.right
                anchors.rightMargin: _RES.s_BORDER
                //            tipVerticalAlignment: Style.CALLOUT_TOP
                //            tipMargin: noteListItem.layoutMini? _RES.s_HALF_DOUBLE_MARGIN: _RES.s_MARGIN
            }

            Row {
                id: noteTakesRow
                spacing: -_RES.s_MARGIN
                anchors.top: noteAvatar.bottom
                anchors.topMargin: -_RES.s_DOUBLE_MARGIN
                anchors.horizontalCenter: parent.horizontalCenter
                Widgets.Icon {
                    id: noteTakesIcon
                    visible: noteTakesBadge.visible
                    name: Icons.POCKET
                    color: Style.Icon.SIDELINE
                    size: _RES.s_ICON_SIZE_SMALL
                    iconStyle: Text.Outline
                    iconStyleColor: Style.Background.WINDOW
//                    z: 0
                }
                Widgets.Badge {
                    id: noteTakesBadge
//                    value: 5
                    anchors.verticalCenter: parent.verticalCenter
                    style: "ALTERNATIVE"
//                    z: 1
                }
            }
        }
    }

    states: [
        State {
            name: "SELECTION"
            when: selectable
            PropertyChanges {
                target: noteListItem
                x: itemSelected.width + _RES.s_DOUBLE_MARGIN
            }
            PropertyChanges {
                target: itemSelected
                enabled: true
                checked: false
            }
        }

    ]
}
