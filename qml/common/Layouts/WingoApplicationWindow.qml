import QtQuick 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtPositioning 5.3
import Wingo 1.0
import "../../lib"
import "../../lib/Toaster.js" as Toaster
import "../../scripts/Utilities.js" as Utilities
import "../../scripts/AppStyle.js" as Style

import "../MessageTray" as MessageTray

ApplicationWindow {
    id: window
    visible: true
    //Needed for QtCreator design mode
    width: 540//238
    height: 960//428
    //-----------
    color: Style.Background.WINDOW

    property bool debug: false
    //Global configuration variable
    property variant config
    //Current GPS location

    //USE THIS VALUE FOR DESKTOP TESTING
    property double latitude  : 43.8174759
    property double longitude : -79.4210148
    property string positionTitle: qsTr("Looking up your<br>current location...")

    property bool logged : false
    property variant currentUser
    property alias currentPage : stack.currentItem


    property variant pages: []

    function goBack(){
        if (stack.depth > 1) stack.pop()
    }

    function goToPage(page){
        stack.push(page)
    }

    function showMessage(title, text) {
        msgBox.title = title
        msgBox.text = text || ""
        msgBox.visible  = true
    }

    function makeToast(message, purpose){
        purpose = purpose || Style.MESSAGE_PURPOSE_INFORM
        return messageTray.message(message)
    }

    function updateLocation(){
        gpsSource.start()
    }

    function requestCurrentUser(){
        currentUserRequester.get()
    }

    ResolutionManager{
        id: _RES
        appWindow: app
    }

    StackView {
        id: stack
        anchors.bottom: messageTray.top
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
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

        initialItem: Qt.resolvedUrl("/qml/pages/Splash.qml")


        delegate: StackViewDelegate {

            pushTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: {                            
                            Qt.inputMethod.hide(); //Hide all input methods
                            if(Utilities.isFunction(exitItem.beforeHidden)) exitItem.beforeHidden()
                            if(Utilities.isFunction(enterItem.beforeShown)) enterItem.beforeShown()
                            exitItem.enabled = false
                        }
                    }
                    PropertyAnimation {
                        target: enterItem
                        property: "x"
                        from: enterItem.width
                        to: 0
                    }
                    ScriptAction {
                        script: {
                            if(Utilities.isFunction(exitItem.afterHidden)) exitItem.afterHidden()
                            if(Utilities.isFunction(enterItem.afterShown)) enterItem.afterShown()
                        }
                    }
                }
            }
            popTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            Qt.inputMethod.hide(); //Hide all input methods
                            if(Utilities.isFunction(exitItem.beforeHidden)) exitItem.beforeHidden()
                            if(Utilities.isFunction(enterItem.beforeShown)) enterItem.beforeShown()
                            enterItem.enabled = true
                        }
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "x"
                        to: enterItem.width
                        from: 0
                    }
                    ScriptAction {
                        script: {
                            if(Utilities.isFunction(exitItem.afterHidden)) exitItem.afterHidden()
                            if(Utilities.isFunction(enterItem.afterShownn)) enterItem.afterShown()
                        }
                    }
                }
            }
        }
    }

    MessageTray.Widget {
        id: messageTray
        anchors.bottom: parent.bottom
    }

    Text {
        visible: window.debug
        anchors.bottom: parent.bottom
        text: wingo.getDeviceId() + "\n" + configRequester.host()+":"+configRequester.port()+"\n pos:" + app.latitude +" , "+app.longitude
        opacity: 0.4
    }

    //======== MESSAGE ERROR SHOW
    MessageDialog {
        id: msgBox
        title: ""
        text: ""
        onAccepted: {
            console.log("And of course you could only agree.")
        }
    }
}
