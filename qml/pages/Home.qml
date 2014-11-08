import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../scripts/AppStyle.js" as Style
import "../common/SideBar" as SideBarWidget
import "../common/OmniBar" as OmniBarWidget

import "../common"

Page {
    id: page
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------
    ColumnLayout {
        width: parent.width
        spacing: 0

        ActionBar {
            id:actionBar
            icon: "wingo48"
            title: "80 Inverlochy Blvd<br><small>Toronto, ON</small>"

            actions: ListModel{
                ListElement {
                    icon: "refresh48"
                    name: "refresh"
                }
                ListElement {
                    icon: "pocket48"
                    name: "pocket"
                }
            }
        }

        OmniBarWidget.OmniBar
        {
            OmniBarWidget.SimpleListItem{
                text: "Recent notes"
            }

            OmniBarWidget.SimpleListItem{
                text: "Popular notes"
            }
            OmniBarWidget.MultiSelectListItem{
                model : 4
            }

            OmniBarWidget.SectionHeader{text:"Trending tags"}

            OmniBarWidget.TagListView {
                height: 400 //This has to be automated somehow
                model: ListModel{id:tagModel}
                onClick: filterBar.search = tag
            }

        }
        ListView {
            model: 10
            width: page.width
            height: page.height - actionBar.height
            clip:true

            delegate: NoteListItem{
                message: "salut"
                takes: 5
                nickname: "sacha"
            }
        }
    }

    Rectangle{
        id:footer
        width: parent.width
        height: 64
        color: Qt.rgba(255, 255, 255, 0.95)
        anchors.bottom: parent.bottom
        Label{
            text: "Post new note..."
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            color: Style.Typography.FADE
        }
        MouseArea{
            anchors.fill: parent
            onClicked: app.setPage("AddNote")
        }
    }

}
