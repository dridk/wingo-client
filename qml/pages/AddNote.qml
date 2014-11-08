import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style
import "../common/OmniBar" as OmniBarWidget

import "../common"
import Wingo 1.0
Page {
    id: page

    ColumnLayout {
        width: parent.width
        spacing: 0
        Layout.alignment: Qt.AlignTop
        ActionBar {
            id:actionBar
              icon: ""
              title: "Add Note"
              actionType: Style.ACTION_BAR_BACK_ACTION
              onClicked: app.pageStack.pop()

        }


        OmniBarWidget.OmniBar{
            id: noteProperties
            property bool postAnonimous: false
            property string expiery: ""
            property int maxTakes: -1

            function composeText(){
                var t = ""
                t = postAnonimous? "Anonimous" : "Signed"
                t += ", "
                t += expiery === ""? "no expiery" : "expire"
                t += ", "
                t += maxTakes === -1? "unlimited" : "limited to " + maxTakes + "takse"
                return t
            }


            OmniBarWidget.MultiSelectListItem{
                model: ["Post as yourself", "Post as Anonimous"]
                selected: 0
                onClick: {
                    switch (index) {
                    case 0:
                        noteProperties.postAnonimous = true
                        break;
                    case 1:
                        noteProperties.postAnonimous = false
                        break;
                    }
                }
            }

            OmniBarWidget.SimpleListItem{
                text: "Never expire"
            }
            OmniBarWidget.SimpleListItem{
                text: "Allow unlimited takes"
            }

        }

        EditArea {
            id: noteEdit
            focus: true

        }

    }
//        ImagePreview
//        {
//            id: noteAttachment
//            //        width: page.width /2.0
//            //        height: page.width /2.0
//            anchors.topMargin: 48
//            anchors.top: noteEdit.bottom
//            anchors.horizontalCenter: parent.horizontalCenter

//            //source: "http://animalia-life.com/data_images/dog/dog4.jpg"
//        }

//        Text {
//            anchors.centerIn: parent
//            text: app.latitude+" " + app.longitude
//        }





}
