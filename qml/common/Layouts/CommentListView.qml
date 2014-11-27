import QtQuick 2.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: _RES.s_MARGIN

    property alias model: commentListViewRepeater.model

    Item{
        anchors.left: parent.left
        anchors.right: parent.right
        height: _RES.s_MARGIN
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
