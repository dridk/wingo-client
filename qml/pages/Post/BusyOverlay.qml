import QtQuick 2.0

import "../../common/Components" as Componenets
import "../../common/Controls" as Widgets

Componenets.OverlayBackground{
    anchors.fill: parent
    Widgets.LoadingIndicator{
        anchors.centerIn: parent
        busy: parent.enabled
    }
}
