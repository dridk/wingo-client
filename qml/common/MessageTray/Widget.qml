import QtQuick 2.0

import "../../scripts/Icons.js" as Icon
import "../../scripts/AppStyle.js" as Style

Rectangle {
    id: trayContainer
    anchors.left: parent.left
    anchors.right: parent.right
    height: tray.height
    color: Style.Palette.BLACK
    clip: true

    function message(text, options) {
        options = options || {}
        var properties = {
            "text": text,
            "purpose": options['purpose'] || Style.MESSAGE_PURPOSE_INFORM,
            "timeout": options['timeout'] || Style.MESSAGE_DURATION_SHORT,
            "dismissible": options['dismissible'] || true
        }
        console.log(JSON.stringify(properties))
        var component = Qt.createComponent("Message.qml")
        if (component.status === Component.Ready)
            return component.createObject(tray, properties)
        else
            return null
    }

    function dismiss(message){
        if (message && message["dismiss"] )
            message.dismiss()
        else return false
    }

    function dismissAll(){
        for (var n in tray.children){
            var message = tray.children[n]
            dismiss(message)
        }
    }

    Behavior on height {
        NumberAnimation {
        }
    }

    Column {
        id: tray
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
