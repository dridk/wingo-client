import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style

import "../../common/Components" as Componenets
import "../../common/Controls" as Widgets

Componenets.ListItemBase{
    id: toolBar
    anchors.left: parent.left
    anchors.right: parent.right
    height: _RES.s_LIST_ITEM_HEIGHT

    readonly property int t_PEN: 0
    readonly property int t_ERASER: 1

    property int tool: t_PEN
    property int penSize: _RES.s_MARGIN

    Row {
        spacing: _RES.s_MARGIN
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        Widgets.Icon {
            name: Icons.DRAW
            color: toolBar.tool === toolBar.t_PEN ? Style.Icon.ACCENT: Style.Icon.SIDELINE
            Componenets.TouchSensorArea{
                anchors.fill: parent
                onClicked: toolBar.tool = toolBar.t_PEN
            }
        }
        Widgets.Icon {
            name: Icons.ERASE
            color: toolBar.tool === toolBar.t_ERASER ? Style.Icon.ACCENT: Style.Icon.SIDELINE
            Componenets.TouchSensorArea{
                anchors.fill: parent
                onClicked: toolBar.tool = toolBar.t_ERASER
            }
        }

        Item {width: _RES.s_DOUBLE_MARGIN; height: _RES.s_ICON_SIZE}

        Widgets.Icon {
            name: Icons.BRUSH_SIZE1
            color: toolBar.penSize === penSize1 ? Style.Icon.ACCENT: Style.Icon.SIDELINE
            property int penSize1: _RES.s_MARGIN
            Componenets.TouchSensorArea{
                anchors.fill: parent
                onClicked: toolBar.penSize = parent.penSize1
            }
        }
        Widgets.Icon {
            name: Icons.BRUSH_SIZE2
            color: toolBar.penSize === penSize2 ? Style.Icon.ACCENT: Style.Icon.SIDELINE
            property int penSize2: _RES.s_DOUBLE_MARGIN
            Componenets.TouchSensorArea{
                anchors.fill: parent
                onClicked: toolBar.penSize = parent.penSize2
            }
        }
        Widgets.Icon {
            name: Icons.BRUSH_SIZE3
            color: toolBar.penSize === penSize3 ? Style.Icon.ACCENT: Style.Icon.SIDELINE
            property int penSize3: _RES.s_TRIPPLE_MARGIN
            Componenets.TouchSensorArea{
                anchors.fill: parent
                onClicked: toolBar.penSize = parent.penSize3
            }
        }
    }
}
