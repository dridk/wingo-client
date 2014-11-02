import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 1.2
import Wingo 1.0
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
    property double latitude  : 43.601337
    property double longitude :1.438675

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

    FontLoader { id: font; name: "Droid Sans" }

    StackView {
        id: stack
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }
        initialItem: Qt.resolvedUrl("pages/Home.qml")


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


}
