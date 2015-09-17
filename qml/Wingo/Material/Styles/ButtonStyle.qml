import QtQuick 2.0
import QtQuick.Controls.Styles 1.3
import QtQuick.Controls 1.2
import Wingo.Material 0.1

ButtonStyle {
    id: style

    padding {
        left: 0
        right: 0
        top: 0
        bottom: 0
    }

    property bool darkBackground: control.hasOwnProperty("darkBackground")
                ? control.darkBackground : Theme.isDarkColor(controlBackground)

    property int controlElevation: control.hasOwnProperty("elevation") ? control.elevation : 1

    property color controlBackground: control.hasOwnProperty("backgroundColor")
            ? control.backgroundColor : controlElevation == 0 ? "transparent" : "white"

    property string context: control.hasOwnProperty("context") ? control.context : "default"

    background: View {
        id: background

        implicitHeight: Units.dp(36)

        radius: Units.dp(2)

        backgroundColor: control.enabled || controlElevation === 0
                ? controlBackground
                : darkBackground ? Qt.rgba(1, 1, 1, 0.12)
                                 : Qt.rgba(0, 0, 0, 0.12)

        elevation: {
            var elevation = controlElevation

            if (elevation > 0 && (control.focus || mouseArea.currentCircle))
                elevation++;

            if(!control.enabled)
                elevation = 0;

            return elevation;
        }

        tintColor: mouseArea.currentCircle || control.focus || control.hovered
           ? Qt.rgba(0,0,0, mouseArea.currentCircle ? 0.1
                            : elevation > 0 ? 0.03
                            : 0.05)
           : "transparent"

        Ink {
            id: mouseArea

            anchors.fill: parent
            focused: control.focus && background.context !== "dialog"
                    && background.context !== "snackbar"
            focusWidth: parent.width - Units.dp(30)
            focusColor: Qt.darker(background.backgroundColor, 1.05)

            Connections {
                target: control.__behavior
                onPressed: mouseArea.onPressed(mouse)
                onCanceled: mouseArea.onCanceled()
                onReleased: mouseArea.onReleased(mouse)
            }
        }
    }
    label: Item {
        implicitHeight: Math.max(Units.dp(36), label.height + Units.dp(16))
        implicitWidth: context == "dialog"
                ? Math.max(Units.dp(64), label.width + Units.dp(16))
                : context == "snackbar" ? label.width + Units.dp(16)
                                        : Math.max(Units.dp(88), label.width + Units.dp(32))

        Label {
            id: label
            anchors.centerIn: parent
            text: control.text
//            style: "button"
            color: control.enabled ? control.hasOwnProperty("textColor")
                                     ? control.textColor : darkBackground ? Theme.dark.textColor
                                                                          : Theme.light.textColor
                    : control.darkBackground ? Qt.rgba(1, 1, 1, 0.30)
                                             : Qt.rgba(0, 0, 0, 0.26)
        }
    }
}
