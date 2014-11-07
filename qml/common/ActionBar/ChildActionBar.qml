import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style

BaseActionBar{
    id: actionBar
    //Needed for QtCreator design mode
    width: 540
    height: 96
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top

    property alias icon: actionBarHeading.icon
    property alias title: actionBarHeading.title
    property alias actionRowListModel: actionBarActions.actionListModel

    signal actionClicked (int index, string name)

    Heading {
        id: actionBarHeading
        actionType: Style.ACTION_BAR_BACK_ACTION
        style: parent.style
        onClicked: app.goBack()
    }

    ActionRow {
        id: actionBarActions
        style: parent.style
        onIconClicked: actionClicked (index, name)
    }

}
