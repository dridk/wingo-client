import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style
import "../Components"

TouchSensorArea {
    id: button
    width: buttonContents.width
    height: _RES.s_ICON_SIZE

    property string style: "DEFAULT"
    property alias color: buttonContents.color
    property alias icon: buttonIcon.name
    property alias text: buttonText.text
    property bool rounded: false

    Rectangle {
        id: buttonContents
        width: buttonContentsWrapper.width + _RES.s_DOUBLE_MARGIN
        height: parent.height
        radius: button.rounded? height * 0.5 : 0
        color: Style.Background.Button[button.style]

        Row{
            id: buttonContentsWrapper
            x: _RES.s_MARGIN
            anchors.verticalCenter: parent.verticalCenter
            spacing: _RES.s_MARGIN

            Icon {
                id: buttonIcon
                anchors.verticalCenter: parent.verticalCenter
                color: Style.Typography.Button[button.style]
                visible: name? true: false
            }

            Label {
                id: buttonText
                anchors.verticalCenter: parent.verticalCenter
                color: Style.Typography.Button[button.style]
                visible: text? true: false
            }

        }

    }
}
