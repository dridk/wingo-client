import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../../common/Components" as Componenets
import "../../common/Controls" as Widgets

Componenets.WidgetItemBase {
    id: noteView
    anchors.left: parent.left
    anchors.right: parent.right

    height: noteViewLayout.height

    property alias avatar: userIdentityAvatar.source
    property alias nickname: userIdentityName.text
    property alias details: noteDetails.text
    property alias takes: noteTakesBadge.value
    property alias expiration: noteExpiery.text

    property alias image: noteImage.source
    property alias message: noteText.text

    Column {
        id: noteViewLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: _RES.s_DOUBLE_MARGIN
        spacing: _RES.s_DOUBLE_MARGIN

        Item {
            anchors.right: parent.right
            anchors.left: parent.left
            height: _RES.s_MARGIN
        }

        RowLayout {
            id: userIdentity
            anchors.left: parent.left
            anchors.right: parent.right
            height: userIdentityAvatar.height

            Widgets.Avatar{
                id: userIdentityAvatar
                Layout.fillWidth: false
                source: "qrc:/qml/Res/images/anonymous.png"
            }
            Column {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                Layout.fillWidth: true
                spacing: _RES.s_HALF_MARGIN

                Item {
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: _RES.s_HALF_MARGIN
                }

                Widgets.Label{
                    id: userIdentityName
//                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.LINK
                }
                Widgets.Label{
                    id: noteDetails
                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.QUOTE
                }
            }
            Column{
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                Layout.fillWidth: false
                spacing: _RES.s_HALF_MARGIN

                Row {
                    id: noteTakesRow
                    spacing: -_RES.s_MARGIN
                    visible: noteTakesBadge.visible
                    Widgets.Badge {
                        id: noteTakesBadge
                        value: 150 //takes
                        anchors.bottom: noteTakesIcon.bottom
                        z: 1
                    }
                    Widgets.Icon {
                        id: noteTakesIcon
                        name: Icons.POCKET
                        color: Style.Icon.SIDELINE
                        size: _RES.s_ICON_SIZE_SMALL
                        iconStyle: Text.Outline
                        iconStyleColor: Style.Background.WINDOW
                        z: 0
                    }
                }
                Widgets.Label {
                    id: noteExpiery
                    anchors.right: parent.right
                    anchors.rightMargin: _RES.s_DOUBLE_MARGIN
                    //Expiery date
                    visible: text!=="None"
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: _RES.s_TEXT_SIZE_MINI
                    color: Style.Typography.QUOTE
                }
            }
        }

        Image {
            id: noteImage
            anchors.left: parent.left
            anchors.right: parent.right
            fillMode: Image.PreserveAspectFit
        }

        Widgets.Label{
            id: noteText
            anchors.right: parent.right
            anchors.left: parent.left
            wrapMode: Text.WordWrap
        }

        Item {
            anchors.right: parent.right
            anchors.left: parent.left
            height: _RES.s_MARGIN
        }
    }
}
