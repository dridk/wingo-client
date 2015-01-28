import QtQuick 2.3
import QtPositioning 5.3
import QtLocation 5.3
import Wingo 1.0

import "../../scripts/StringFormat.js" as StringFormat
import "../../scripts/AppStyle.js" as Style
import "../../scripts/Icons.js" as Icons
import "../Components" as Componenets
import "./" as Widgets

Componenets.WidgetItemBase {
    id: mapView
    anchors.left: parent.left
    anchors.right: parent.right
    height: _RES.s_LIST_ITEM_HEIGHT

    color: Style.Background.WINDOW

    property string noteID: ""
    property alias center: mapLoader.center
    property var me: app.coordinate
    property double zoom: 15

    property bool expanded: false
    property bool expandable: true
    property alias pressed : mouseArea.pressed
    property bool allowGestures: false

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

//    function refresh() {
//        var request = "";
//        if (noteID !== "") {
//            request = "http://"+mapRequest.host()+":"+mapRequest.port()+"/notes/" + noteId + "/map"
//            console.debug("MAP REQUESTS : "+request)
//        }else{
//            //Use lat and lon here!!!
//            request = ""
//        }
//        mapLoader.source = request;
//    }

//    onNoteIDChanged: refresh()
//    onLatitudeChanged: refresh()
//    onLongitudeChanged: refresh()

    Behavior on height {NumberAnimation{}}

    Plugin {
            id: locationPlugin
            allowExperimental: true
            name: "nokia"
            PluginParameter { name: "app_id"; value: "gSIJpP4LI9XNNUl2CKYt" }
            PluginParameter { name: "token"; value: "jCjx8lcKnDsGXbRXSIDe9w" }


            // code here to choose the plugin as necessary
        }

//    Location {
//            id: location
//            coordinate {
//                latitude: mapView.latitude
//                longitude: mapView.longitude
//            }
//    }
    Item { //Map image wrapper to make sure we do not clip the shadow off in the parent view
        width: parent.width
        height: parent.height
        clip: true

        Map {
            id: mapLoader
            width: parent.width
            height: width
            anchors.centerIn: parent

            plugin: locationPlugin

            zoomLevel: mapLoader.maximumZoomLevel - 5

            gesture.enabled: false

//            MapCircle{
//                center: parent.center
//                radius: 5
//                color: 'green'
//            }

            MapCircle{
                center: mapView.me
                radius: 5
                color: 'red'
            }

//            LoadingIndicator{
//                anchors.centerIn: parent
//                anchors.verticalCenterOffset: - U.px(10)
//                busy: mapLoader.status === Image.Loading
//                opacity: busy? 1: 0
//                Behavior on opacity {NumberAnimation{}}
//            }

            MapQuickItem {
                coordinate: parent.center
                zoomLevel: parent.zoomLevel
                anchorPoint.x: mapCursor.width / 2
                anchorPoint.y: mapCursor.height * 0.8
                sourceItem: Widgets.Icon{
                    id: mapCursor
                    name: Icons.LOCATION
                    color: Style.Palette.MAGENTA
                    size: _RES.s_ICON_SIZE_SMALL
                    iconStyle: Text.Outline
                    iconStyleColor: Style.Background.WINDOW
                }
            }
        }
    }

    Widgets.Label{
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: _RES.s_MARGIN
        text: "@" + StringFormat.trim(parent.center.latitude, 10) + ", " + StringFormat.trim(parent.center.longitude, 10)
        color: Style.Palette.MAGENTA
        font.pixelSize: _RES.s_TEXT_SIZE_MINI
        style: Text.Outline
        styleColor: Style.Background.WINDOW
    }

//    MouseArea{
//        id: mouseArea
//        //TODO Make this draggable
//        //so the map expands on drag, rather then on click
//        property bool dragging: false
//        property real verticalOffset: 0
//        anchors.fill: parent
//        onClicked: {
//            if (parent.expandable) parent.toggle();
//            parent.click()
//        }
//        onPressed: verticalOffset=mouseY
//        onReleased: {
//            if (dragging) parent.toggle()
//            dragging = false
//        }
//        onMouseYChanged: {
//            if(parent.expandable && pressed){
//                verticalOffset = mouseY - verticalOffset
//                var newHeight = mapView.height + verticalOffset
//                if (newHeight < mapLoader.height &&
//                        newHeight > _RES.s_LIST_ITEM_HEIGHT) mapView.height = newHeight
//                if (verticalOffset !== 0 ) dragging = true
//            }
//        }
//    }

    Widgets.Button{
        id: mouseArea
        icon: Icons.CARRET_DOWN
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        onClicked: {
            if (parent.expandable) parent.toggle();
            parent.click()
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
                focus: true
            }
            PropertyChanges {
                target: mapLoader
                gesture.enabled: allowGestures && true
            }
            PropertyChanges {
                target: mapCursor
                size: _RES.s_ICON_SIZE
            }
            PropertyChanges {
                target: mouseArea
                icon: Icons.CARRET_UP
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

