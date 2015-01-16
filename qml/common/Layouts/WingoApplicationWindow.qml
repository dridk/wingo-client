/*
 * =====================================================
 *   WingoApplication
 *   This is an ApplicationWindow containing a PageStack
 * =====================================================
 */

import QtQuick 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import Wingo 1.0
import "../../lib"
import "../../lib/Toaster.js" as Toaster
import "../../scripts/Utilities.js" as Utilities
import "../../scripts/AppStyle.js" as Style
import "../MessageTray" as MessageTray

ApplicationWindow {
    id: window
    visible: true
    width: 540//238
    height: 960//428
    color: Style.Background.WINDOW
    //---------------------------
    //Application global property
    //---------------------------
    property alias currentPage   : stack.currentItem
    property variant pages: []

    //---------------------------
    //Application global function
    //---------------------------
    /**
     * Go To Previous Page
     */
    function goBack(){
        if (stack.depth > 1) stack.pop()
    }

    /**
     * Go To specific
     * @param page: Page Component
     */
    function goToPage(page){
        stack.push(page)
    }
    /**
     * Show a message box
     * @param title: message box title
     * @param text: message box text
     */
    function showMessage(title, text) {
        msgBox.title = title
        msgBox.text = text || ""
        msgBox.visible  = true
    }
    /**
     * Show a message toast
     * @param message: message in toast
     * @param purpose: message box
                       MESSAGE_PURPOSE_INFORM,
                       MESSAGE_PURPOSE_NOTIFY,
                       MESSAGE_PURPOSE_ALERT
     */
    function makeToast(message, purpose){
        purpose = purpose || Style.MESSAGE_PURPOSE_INFORM
        return messageTray.message(message)
    }

    //---------------------------
    //Application global Component
    //---------------------------

    ResolutionManager{
        id: _RES
        //appWindow: app
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

        initialItem: app.pages["Home"]//Qt.resolvedUrl("/qml/pages/Splash.qml")


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

    //---------------------------
    //Toast Components
    //---------------------------
    MessageTray.Widget {
        id: messageTray
        anchors.bottom: parent.bottom
    }

    //---------------------------
    //Message Box Components
    //---------------------------
    MessageDialog {
        id: msgBox
        title: ""
        text: ""
        onAccepted: {
            console.log("And of course you could only agree.")
        }
    }
}
