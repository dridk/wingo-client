import QtQuick 2.0

import "../../common/Components" as Componenets
import "../../common/Controls" as Widgets
import "../../scripts/AppStyle.js" as Style
import "../../scripts/Icons.js" as Icons

Componenets.WidgetItemBase {
    id: addImage
    width: _RES.s_IMAGE_PREVIEWS_SIZE
    height: width

    color: Style.Background.WINDOW
    border.color: Style.Border.DARK

    property alias source: addImageImage.source
    property bool isEmpty: addImageImage.status == Image.Null ? true : false

    signal remove
    signal add
    signal edit

    Image{
        id: addImageImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        cache: false
        anchors.margins: _RES.s_MARGIN
    }

    Widgets.Icon {
        name: addImageImage.status === Image.Ready? Icons.DRAW : Icons.ADD
        size: _RES.s_ICON_SIZE_BIG
        color: Style.Icon.SIDELINE
        anchors.centerIn: parent
        iconStyle: Text.Outline
        iconStyleColor: Style.Background.VIEW

        Rectangle {
            anchors.fill: parent
            anchors.margins: - _RES.s_BORDER
            radius: width * 0.5
            color: Style.Palette.LIGHTEN
        }
    }

    Componenets.TouchSensorArea {
        anchors.fill: parent
        onClicked: addImageImage.status === Image.Ready? addImage.edit() : addImage.add()
    }

    Widgets.Button{
        height: width
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: -_RES.s_DOUBLE_MARGIN
        color: Style.Palette.LIGHTEN
        icon: Icons.AXE
        rounded: true
        onClicked: {
            addImageImage.source = "";
            addImage.remove();
        }
        visible: addImageImage.status === Image.Ready
    }
}
