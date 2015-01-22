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
    property var pages: []
    property alias busy: stack.busy
//    property var passFocus: function(e){
//        if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace
//                || event.key === Qt.Key_Menu || event.key === Qt.Key_Meta
//                || event.key === Qt.Key_Home || event.key === Qt.Key_F12 )
//            event.accepted = false;
//    }

//    Keys.onReleased: {
//        if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
//            event.accepted = stack.currentItem.back();
//        }
//        if (event.key === Qt.Key_Menu || event.key === Qt.Key_Meta ) {
//            event.accepted = stack.currentItem.menu();
//        }
//        if (event.key === Qt.Key_Home || event.key === Qt.Key_F12 ) {
//            event.accepted = stack.currentItem.home(event);
//        }
//    }z

    //---------------------------
    //Application global functions
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

    Item{
        id: _RES
        //appWindow: app
        //Base point size
        property int s_BASE_UNIT: U.px(8)

        //Fonts::
        property int s_TEXT_SIZE_MEDIUM: U.px(22)
        property int s_TEXT_SIZE_SMALL: U.px(18)
        property int s_TEXT_SIZE_MINI: U.px(14)

        //Layouts::
        property int s_MARGIN: U.px(8)
        property int s_DOUBLE_MARGIN: U.px(16)
        property int s_HALF_DOUBLE_MARGIN: U.px(24)
        property int s_TRIPPLE_MARGIN: U.px(32)
        property int s_QUADRO_MARGIN: U.px(48)
        property int s_HALF_MARGIN: U.px(4)

        property int s_BORDER: U.px(2)

        property int s_LIST_ITEM_HEIGHT: U.px(48)
        property int s_LIST_ITEM_DOUBLE_HEIGHT: U.px(96)

        property int s_ICON_SIZE: U.px(48)
        property int s_ICON_SIZE_SMALL: U.px(32)
        property int s_ICON_SIZE_MINI: U.px(24)
        property int s_ICON_SIZE_BIG: U.px(64)
        property int s_ICON_SIZE_HUGE: U.px(92)

        //Special cases::
        property int s_NOTE_LIST_MIN_HEIGHT: U.px(96)
        property int s_ACTION_BAR_HEIGHT: U.px(82)
        property int s_ACTION_BAR_BUTTON_SIZE: U.px(40)
        property int s_OMNI_BAR_HEIGHT: U.px(56)
        property int s_IMAGE_PREVIEWS_SIZE: U.px(210)
        property int s_ACTION_BUTTON_SIZE: U.px(96)
    }



    StackView {
        id: stack
        anchors.bottom: messageTray.top
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        // Implements back key navigation

//        initialItem: app.pages["Home"]

        delegate: StackViewDelegate {

            replaceTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            Qt.inputMethod.hide(); //Hide all input methods
                            if (exitItem) exitItem.hide();
                            enterItem.show()
                            if (exitItem) exitItem.enabled = false
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
                            if (exitItem) exitItem.hidden()
                            enterItem.shown()
                        }
                    }
                }
            }

            pushTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            Qt.inputMethod.hide(); //Hide all input methods
                            if (exitItem) exitItem.hide();
                            enterItem.show()
                            if (exitItem) exitItem.enabled = false
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
                            if (exitItem) exitItem.hidden()
                            enterItem.shown()
                        }
                    }
                }
            }

            popTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            Qt.inputMethod.hide(); //Hide all input methods
                            exitItem.hide()
                            enterItem.show()
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
                            exitItem.hidden()
                            enterItem.shown()
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
