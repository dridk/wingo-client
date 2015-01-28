import QtQuick 2.0

import "../Controls" as Widgets

Grid {
    spacing: _RES.s_MARGIN

    property alias model: tagList.model

    Repeater {
        id: tagList
        Widgets.TagItem {
            text: modelData
        }
    }
}
