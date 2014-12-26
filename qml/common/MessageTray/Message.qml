import QtQuick 2.0
import "../../scripts/Icons.js" as Icon
import "../../scripts/AppStyle.js" as Style
import "../Components" as Componenets
import "../Controls" as Widgets

Componenets.ListItemBase {
    id: messageContainer
    anchors.left: parent.left
    anchors.right: parent.right
    height: _RES.s_LIST_ITEM_HEIGHT

    property alias text: listItemLabel.text
    property int purpose: Style.MESSAGE_PURPOSE_INFORM
    property bool dismissible: true
    property alias timeout: dismissTimer.interval

    Component.onCompleted: if (timeout > 0) dismissTimer.start()

    function dismiss(){
        destroy()
    }

    Widgets.Icon {
        id: listItemIcon
        name: icons[parent.purpose]
        size: _RES.s_ICON_SIZE_SMALL
        color: styles[parent.purpose]
        anchors.left: parent.left
        anchors.leftMargin: _RES.s_HALF_DOUBLE_MARGIN
        anchors.verticalCenter: parent.verticalCenter
        visible: name !== ""
        property variant styles: [
            Style.Palette.SILVER,
            Style.Palette.AZURES,
            Style.Palette.YELLOW
        ]
        property variant icons: [
            Icon.INFO,
            Icon.NOTICE,
            Icon.ALERT
        ]
    }

    Widgets.Label{
        id: listItemLabel
        text: "test"
        color: styles[parent.purpose]
        anchors.left: parent.left
        anchors.leftMargin: _RES.scale(72)
        anchors.verticalCenter: parent.verticalCenter
        property variant styles: [
            Style.Palette.SILVER,
            Style.Palette.AZURES,
            Style.Palette.YELLOW
        ]
    }

    Widgets.Button {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: _RES.s_DOUBLE_MARGIN
        icon: Icon.AXE
        style: "INVERTED"
        onClicked: parent.dismiss()
        visible: parent.dismissible
    }

    Rectangle{
        id: border
        height: _RES.s_BORDER
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: Style.Palette.CYAN
        visible: parent.timeout > 0

        NumberAnimation on width{
            from: messageContainer.width
            to: 0
            duration: dismissTimer.interval
            running: dismissTimer.running
        }
    }

    Timer{
        id: dismissTimer
        repeat: false
        onTriggered: parent.dismiss()
    }

}
