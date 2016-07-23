
import VPlayApps 1.0
import QtQuick 2.0

Item {
  width: parent.width
  height: dp(120)

  Rectangle {
    id: bgImage
    color: Theme.tintColor
    radius: 0
    anchors.fill: parent

    Column {
      anchors.centerIn: parent
      width: parent.width

      // Profile image
      Rectangle {
        id: profileImage
        width: dp(50)
        height: dp(50)
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
      }

//      Item { height: dp(5); width: parent.width } // spacer

      AppText {
        width: parent.width
        horizontalAlignment: Text.Center
        color: "white"
        text: "eugene trounev"
        font.pixelSize: sp(14)
        font.bold: true
        font.family: Theme.boldFont.name
      }

      AppText {
        width: parent.width
        text: "@its"
        horizontalAlignment: Text.Center
        color: "white"
        font.pixelSize: sp(13)
      }
    }
  }
}
