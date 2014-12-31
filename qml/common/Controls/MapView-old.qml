import QtQuick 2.3
import Wingo 1.0

import "../../scripts/StringFormat.js" as StringFormat
import "../../scripts/AppStyle.js" as Style
import "../../scripts/Icons.js" as Icons
import "../Components" as Componenets

Componenets.WidgetItemBase {
    id: mapView
    anchors.left: parent.left
    anchors.right: parent.right
    height: _RES.s_LIST_ITEM_HEIGHT

    color: Style.Background.WINDOW

    property string noteID: ""
    property double latitude: 0
    property double longitude: 0
    property double zoom: 15

    property bool expanded: false
    property bool expandable: true
    property alias pressed : mouseArea.pressed

    signal click

    function expand() {
        focus = true;
        Qt.inputMethod.hide();
        expanded = true
    }

    function contract() {
        focus = false;
        expanded = false
    }

    function toggle() {
        if (expanded) contract();
        else expand();
    }

    function refresh() {
        var request = "";
        if (noteID !== "") {
            request = "http://"+mapRequest.host()+":"+mapRequest.port()+"/notes/" + noteId + "/map"
            console.debug("MAP REQUESTS : "+request)
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

            LoadingIndicator{
                anchors.centerIn: parent
                anchors.verticalCenterOffset: - _RES.scale(10)
                busy: mapLoader.status === Image.Loading
                opacity: busy? 1: 0
                Behavior on opacity {NumberAnimation{}}
            }

            Icon{
                id: mapCursor
                name: Icons.LOCATION
                anchors.centerIn: parent
                anchors.verticalCenterOffset: - _RES.scale(10)
                color: Style.Palette.MAGENTA
                visible: mapLoader.status === Image.Ready
                size: _RES.s_ICON_SIZE_SMALL
                iconStyle: Text.Outline
                iconStyleColor: Style.Background.WINDOW
            }

            onStatusChanged: {
                if (status === Image.Error) {
                    mapView.state = "HIDDEN"
                    app.makeToast(qsTr("Couldn't load map"), Style.MESSAGE_PURPOSE_ALERT)
                }
            }
        }
    }

    Label{
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: _RES.s_MARGIN
        text: "@" + StringFormat.trim(parent.latitude, 10) + ", " + StringFormat.trim(parent.longitude, 10)
        color: Style.Palette.MAGENTA
        font.pixelSize: _RES.s_TEXT_SIZE_MINI
        style: Text.Outline
        styleColor: Style.Background.WINDOW
    }

    Request{
        id: mapRequest
        // Hum... it's seems this is used only to get host and port from Map request picture... Very ugly...
    }

    MouseArea{
        id: mouseArea
        //TODO Make this draggable
        //so the map expands on drag, rather then on click
        property bool dragging: false
        property real verticalOffset: 0
        anchors.fill: parent
        onClicked: {
            if (parent.expandable) parent.toggle();
            parent.click()
        }
        onPressed: verticalOffset=mouseY
        onReleased: {
            if (dragging) parent.toggle()
            dragging = false
        }
        onMouseYChanged: {
            if(parent.expandable && pressed){
                verticalOffset = mouseY - verticalOffset
                var newHeight = mapView.height + verticalOffset
                if (newHeight < mapLoader.height &&
                        newHeight > _RES.s_LIST_ITEM_HEIGHT) mapView.height = newHeight
                if (verticalOffset !== 0 ) dragging = true
            }
        }
    }

    states: [
        State {
            name: ""
            PropertyChanges {
                target: mapView
                height: _RES.s_LIST_ITEM_HEIGHT
            }
        },
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
        },
        State{
            name: "HIDDEN"
            when: mapLoader.status === Image.Error
            PropertyChanges {
                target: mapView
                height: 0
            }
        }

    ]

}

