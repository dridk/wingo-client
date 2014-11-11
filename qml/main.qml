import QtQuick 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtPositioning 5.3
import Wingo 1.0
import "lib"
import "scripts/AppStyle.js" as Style

ApplicationWindow {
    id: app
    visible: true
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------
    color: Style.Background.WINDOW

    Component.onCompleted: {
        configRequester.get()
    }
    //Global configuration variable
    property variant config
    //Current GPS location

    //USE THIS VALUE FOR DESKTOP TESTING
    property double latitude  : 43.601337
    property double longitude : 1.438675


    property variant pages: {
        "Home": Qt.resolvedUrl("pages/Home.qml"),
                "AddNote": Qt.resolvedUrl("pages/AddNote.qml")
    }
    function goBack(){
        stack.pop()
    }

    function goToPage(page){
        stack.push(page);
    }

    function showMessage(message) {
        msgTextBox.text = message
        msgBox.visible  = true
    }

    function updateLocation(){
        gpsSource.start()
    }


    FontLoader { id: font; name: "Droid Sans" }
    FontLoader { id: iconFont; name: "Icon Font"; source: "Res/icons/icons.ttf"}


    ResolutionManagerCahce{
        id: _RES
        appWindow: app
        intendedScreenWidth: 540
        intendedScreenHeight: 960

        //        refreshOnResize: true

        /*Preset app-wide sizes
          These are only recalculated one
          */
        //Base point size
        property int s_BASE_UNIT: 8

        //Fonts::
        property int s_TEXT_SIZE_MEDIUM: 24
        property int s_TEXT_SIZE_SMALL: 18

        //Layouts::
        property int s_MARGIN: 8
        property int s_DOUBLE_MARGIN: 16
        property int s_HALF_DOUBLE_MARGIN: 24
        property int s_TRIPPLE_MARGIN: 32
        property int s_QUADRO_MARGIN: 48

        property int s_BORDER: 2

        property int s_LIST_ITEM_HEIGHT: 48
        property int s_LIST_ITEM_DOUBLE_HEIGHT: 96

        property int s_ICON_SIZE: 48

        //Special cases::
        property int s_NOTE_LIST_MIN_HEIGHT: 96
        property int s_ACTION_BAR_HEIGHT: 96
        property int s_OMNI_BAR_HEIGHT: 64
        property int s_IMAGE_PREVIEWS_SIZE: 210
    }


    StackView {
        id: stack
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }
        initialItem: Qt.resolvedUrl("pages/Splash.qml")


        //        initialItem: Rectangle {
        //            anchors.fill: parent
        //            color: Style.Palette.CYAN
        //            Timer{interval: 3000; running:true; onTriggered: stack.push(app.pages["Home"])}
        //        }

        delegate: StackViewDelegate {
            //            function transitionFinished(properties)
            //            {
            //                properties.exitItem.state = ""
            //            }

            pushTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: exitItem.state = "DISABLED"
                    }
                    PropertyAnimation {
                        target: enterItem
                        property: "x"
                        from: enterItem.width
                        to: 0
                    }
                }
            }
            popTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: enterItem.state = ""
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "x"
                        to: enterItem.width
                        from: 0
                    }
                }
            }
        }
    }
    //======Added by Sacha
    Request{
        id:configRequester
        source:"/config"
        onSuccess:  app.config = data.results

    }


    //======== MESSAGE ERROR SHOW
    Rectangle {
        id:msgBox
        width: parent.width
        height: 200
        anchors.centerIn: parent
        color:"#00b8cc"
        visible: false
        Label {
            id: msgTextBox
            anchors.centerIn: parent
            text: "ERROR happens"
            color: "white"
            font.pixelSize:25
        }
        MouseArea {
            anchors.fill: parent
            onClicked: msgBox.visible=false
        }


    }

    //=========== POSITIONNING GPS
    PositionSource
    {
        id: gpsSource
        updateInterval: 1000
        active: Qt.platform.os == "android" ? true : false
        onPositionChanged: {
            if ( Qt.platform.os == "android") {
            var coord = gpsSource.position.coordinate;
            app.longitude = coord.longitude;
            app.latitude = coord.latitude;
            }

            //            console.debug(coord.longitude +" " +coord.latitude )
        }
    }


    Text {
        text: wingo.getDeviceId() + "\n" + configRequester.host+":"+configRequester.port+"\n pos:" + app.latitude +" , "+app.longitude
    }


}
