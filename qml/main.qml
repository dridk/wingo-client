import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 1.2

import "scripts/AppStyle.js" as Style

ApplicationWindow {
    id: app
    visible: true
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------

    color: Style.Background.WINDOW

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
    }
}
