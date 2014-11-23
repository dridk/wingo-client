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
    width: 540//238
    height: 960//428
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

    property bool logged : false
    property variant currentUser
    property alias currentPage : stack.currentItem


    property variant pages: {        
        "Home":     Qt.resolvedUrl("pages/Home.qml"),
        "Post":     Qt.resolvedUrl("pages/Post.qml"),
        "Pocket":   Qt.resolvedUrl("pages/Pocket.qml"),
        "Login":    Qt.resolvedUrl("pages/Login.qml"),
        "Account":  Qt.resolvedUrl("pages/Account.qml"),
        "NoteView":  Qt.resolvedUrl("pages/NoteView.qml")
    }

    function goBack(){
        if (stack.depth > 1) stack.pop()
    }

    function goToPage(page){
        stack.push(page)
    }

    function showMessage(message) {
        msgTextBox.text = message
        msgBox.visible  = true
    }

    function updateLocation(){
        gpsSource.start()
    }

    function requestCurrentUser(){
        currentUserRequester.get()
    }



//    FontLoader { id: font; name: "Droid Sans" }
    //cpp loaded
    //FontLoader { id: iconFont; name: "Icon Font"; source: "Res/icons/icons.ttf"}


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
        property int s_TEXT_SIZE_MEDIUM: 20
        property int s_TEXT_SIZE_SMALL: 18
        property int s_TEXT_SIZE_MINI: 14

        //Layouts::
        property int s_MARGIN: 8
        property int s_DOUBLE_MARGIN: 16
        property int s_HALF_DOUBLE_MARGIN: 24
        property int s_TRIPPLE_MARGIN: 32
        property int s_QUADRO_MARGIN: 48
        property int s_HALF_MARGIN: 4

        property int s_BORDER: 2

        property int s_LIST_ITEM_HEIGHT: 48
        property int s_LIST_ITEM_DOUBLE_HEIGHT: 96

        property int s_ICON_SIZE: 48
        property int s_ICON_SIZE_SMALL: 32
        property int s_ICON_SIZE_MINI: 24
        property int s_ICON_SIZE_BIG: 64
        property int s_ICON_SIZE_HUGE: 92

        //Special cases::
        property int s_NOTE_LIST_MIN_HEIGHT: 96
        property int s_ACTION_BAR_HEIGHT: 82
        property int s_ACTION_BAR_BUTTON_SIZE: 40
        property int s_OMNI_BAR_HEIGHT: 56
        property int s_IMAGE_PREVIEWS_SIZE: 210
        property int s_ACTION_BUTTON_SIZE: 82
    }


    StackView {
        id: stack
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased: {
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                 currentItem.back();
                 event.accepted = true;
             }
            if (event.key === Qt.Key_Menu || event.key === Qt.Key_Meta ) {
                currentItem.menu();
                event.accepted = true;
            }
            if (event.key === Qt.Key_Home || event.key === Qt.Key_F12 ) {
                currentItem.home(event);
            }
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
                        script: exitItem.enabled = false
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
                        script: enterItem.enabled = true
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

    Request {
        id: currentUserRequester
        source:"/users/me"
        onSuccess: {
            console.debug("Current User loaded")
            console.debug( data["results"])

            app.currentUser = data["results"]
            app.logged = true
        }

        onError: {
            console.debug("Cannot load current user. Authified ?")
            app.logged = false

        }
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
        anchors.bottom: parent.bottom
        text: wingo.getDeviceId() + "\n" + configRequester.host+":"+configRequester.port+"\n pos:" + app.latitude +" , "+app.longitude
        opacity: 0.4
    }


}
