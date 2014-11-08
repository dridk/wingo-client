import QtQuick 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtPositioning 5.3
import Wingo 1.0
import "scripts/AppStyle.js" as Style

ApplicationWindow {
    id: app
    visible: true
    //Needed for QtCreator design mode
    width: 540
    height: 960
    property alias pageStack : stack
    property alias initialPage : stack.initialItem
    property var pages

    function setPage(pageName){
        console.debug("set page:"+pageName )
        pageStack.push(Qt.resolvedUrl(pages[pageName]))
    }

    //-----------
    FontLoader { id: font; name: "Droid Sans" }

    Rectangle {
        color: Style.Background.WINDOW
        anchors.fill: parent

        StackView {
            id: stack
            anchors.fill: parent
            // Implements back key navigation
            focus: true
            Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                                 stackView.pop();
                                 event.accepted = true;
                             }

            delegate: StackViewDelegate {
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



    }
    //=========== POSITIONNING GPS


}
