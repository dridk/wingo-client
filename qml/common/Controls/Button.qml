import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style
import "../Components"

TouchSensorArea {
    id: button
    width: rectangle1.width
    height: 48

    property string style: "DEFAULT"
    property alias icon: buttonIcon.name
    property alias text: buttonText.text

    Rectangle {
        id: rectangle1
        width: childrenRect.width + 16
        height: parent.height
        color: Style.Background.Button[button.style]

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Icon {
                id: buttonIcon
                anchors.verticalCenter: parent.verticalCenter
                color: Style.Typography.Button[button.style]
            }

            Label {
                id: buttonText
                anchors.verticalCenter: parent.verticalCenter
                color: Style.Typography.Button[button.style]
                text: "Button"
            }

        }

    }
}
