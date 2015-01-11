import QtQuick 2.0
import "../Controls" as Widgets

Column {
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: _RES.s_MARGIN

    property alias model: commentListViewRepeater.model
    property bool busy: false

    Item{
        anchors.left: parent.left
        anchors.right: parent.right
        height: _RES.s_MARGIN
    }

    Widgets.LoadingIndicator{
        busy: parent.model.isLoading || parent.busy
        anchors.horizontalCenter: parent.horizontalCenter
        visible: busy? 1 : 0
    }

    Repeater {
        id: commentListViewRepeater
        CommentListItem{}
    }

    Item{
        anchors.left: parent.left
        anchors.right: parent.right
        height: _RES.s_DOUBLE_MARGIN
    }
}
