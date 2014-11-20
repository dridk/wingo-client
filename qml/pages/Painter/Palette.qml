import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style

import "../../common/Components" as Componenets

Item {
    id: paletteWidget
    anchors.left: parent.left
    anchors.right: parent.right
    height: _RES.s_LIST_ITEM_HEIGHT

    property color color: palette[0]
    property var palette: [
                            Style.Palette.BLACK,
                            Style.Palette.DEEPSEA,
                            Style.Palette.CYAN,
                            Style.Palette.NIGHTSKY,
                            Style.Palette.MAGENTA,
                            Style.Palette.SUNRISE,
                            Style.Palette.YELLOW
                            ]

    Row{
        id: paletteWidgetRow
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: _RES.s_MARGIN

        property int _selectedIndex: 0

        Repeater{
            model: paletteWidget.palette
            Rectangle{
                width: paletteWidget.width / paletteWidget.palette.length - _RES.s_HALF_DOUBLE_MARGIN
                height: width
                color: modelData
                border.color: paletteWidgetRow._selectedIndex === index? "black" : "white"
                border.width: _RES.s_BORDER
                Componenets.TouchSensorArea{
                    anchors.fill: parent
                    onClicked: {
                        paletteWidgetRow._selectedIndex = index;
                        paletteWidget.color = modelData;
                    }
                }
            }
        }

    }
}
