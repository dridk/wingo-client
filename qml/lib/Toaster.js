var _duration = 5000
var _parent = null
var _component = 'import QtQuick 2.0; Rectangle {id:toast;color: "black"; width: childrenRect.width + 20; height: childrenRect.height + 10; property alias text: label.text; property alias timeout: timeoutTimer.interval; property alias running: timeoutTimer.running; Text{id:label;x:10;y:5;color:"white"} Timer{id:timeoutTimer;onTriggered:toast.destroy()}}'

function parent(parent){
    if (parent === undefined) return _parent;
    _parent = parent;
    return _parent;
}

function componenet(componenet){
    if (componenet === undefined) return _component;
    _component = componenet;
    return _component;
}

function toast(message, duration, componenet, parent) {
    console.log("Making toast...")
    if (message === undefined || message === null || message === "") return false;
    if (componenet === undefined && _component === null) return false;
    if (parent === undefined && _parent === null) return false;
    if (parent) _parent = parent;
    if (componenet) _component = componenet;
    var d = duration || _duration

    console.log("Creating componenet")
    var toast = Qt.createQmlObject(_component, _parent);
    if (toast === null) {
        // Error Handling
        console.log("Error creating object");
    }else {
        console.log("Adjusting location")
        toast.text = message
        toast.x = _parent.width / 2 - toast.width / 2
        toast.y = _parent.height - toast.height * 4
        toast.timeout = _duration
        toast.running = true
    }
}
