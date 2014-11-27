import QtQuick 2.3
import Wingo 1.0

import "../../scripts/AppStyle.js" as Style
import "../../scripts/Icons.js" as Icons
import "../Components" as Componenets

Componenets.WidgetItemBase {
    id: mapView
    anchors.left: parent.left
    anchors.right: parent.right
    height: _RES.s_LIST_ITEM_HEIGHT

    property string noteID: ""
    property double latitude: 0
    property double longitude: 0
    property double zoom: 15

    property bool expanded: false

    function expand() {
        expanded = true
    }

    function contract() {
        expanded = false
    }

    function toggle() {
        expanded = !expanded
    }

    function refresh() {
        var request = "";
        if (noteID !== "") {
            request = "http://localhost:5000/notes/" + noteId + "/map"
        }else{
            //Use lat and lon here!!!
            request = ""
        }
        mapLoader.source = request;
    }

    onNoteIDChanged: refresh()
    onLatitudeChanged: refresh()
    onLongitudeChanged: refresh()

    Behavior on height {NumberAnimation{}}

    Item { //Map image wrapper to make sure we do not clip the shadow off in the parent view
        width: parent.width
        height: parent.height
        clip: true

        Image {
            id: mapLoader
            width: parent.width
            height: width
            anchors.centerIn: parent
            anchors.verticalCenterOffset: _RES.scale(10)

            Icon{
                id: mapCursor
                name: Icons.LOCATION
                anchors.centerIn: parent
                anchors.verticalCenterOffset: - _RES.scale(10)
                color: Style.Palette.MAGENTA
                visible: mapLoader.status === Image.Ready
                size: _RES.s_ICON_SIZE_SMALL
            }
        }
    }

    Label{
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: _RES.s_MARGIN
        text: parent.latitude + " " + parent.longitude
        color: Style.Palette.MAGENTA
        font.pixelSize: _RES.s_TEXT_SIZE_MINI
    }

    Request{
        id: mapRequest
    }

    MouseArea{
        //TODO Make this draggable
        //so the map expands on drag, rather then on click
        anchors.fill: parent
        onClicked: parent.toggle()
    }

    states: [
        State {
            name: "EXPANDED"
            when: mapView.expanded
            PropertyChanges {
                target: mapView
                height: mapLoader.height
            }
            PropertyChanges {
                target: mapLoader
                anchors.verticalCenterOffset: 0
            }
            PropertyChanges {
                target: mapCursor
                size: _RES.s_ICON_SIZE
            }
        }

    ]

}

